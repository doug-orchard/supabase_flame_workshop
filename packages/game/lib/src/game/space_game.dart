import 'dart:async';
import 'dart:math';
import 'dart:ui' show Color, Offset, Rect;

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';

import '../app/overlay_ids.dart';
import '../db/score_service.dart';
import '../game_config.dart';
import '../net/net_events.dart';
import '../net/net_service.dart';
import '../net/payloads/death_payload.dart';
import '../net/payloads/hit_payload.dart';
import '../net/payloads/lobby_presence.dart';
import '../net/payloads/round_start_payload.dart';
import '../net/payloads/ship_state_payload.dart';
import '../net/payloads/shoot_payload.dart';
import 'components/asteroid_field.dart';
import 'components/bullet.dart';
import 'components/explosion.dart';
import 'components/player_ship.dart';
import 'components/remote_ship.dart';
import 'components/starfield.dart';
import 'components/storm_zone.dart';
import 'game_phase.dart';
import 'round_state.dart';

class SpaceGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  SpaceGame({required this.net, required this.myId, required this.scoreService})
    : super(
        camera: CameraComponent.withFixedResolution(width: 960, height: 540),
      );

  final NetService net;
  final String myId;
  final ScoreService scoreService;

  final phase = ValueNotifier<GamePhase>(GamePhase.lobby);
  final roster = ValueNotifier<List<LobbyPresence>>([]);
  final hpNotifier = ValueNotifier<double>(GameConfig.shipMaxHp);
  final aliveCount = ValueNotifier<int>(0);
  final winnerName = ValueNotifier<String?>(null);
  final spectatingName = ValueNotifier<String?>(null);

  String myName = 'Pilot-${1000 + Random().nextInt(9000)}';
  int myColorIndex = Random().nextInt(GameConfig.shipColors.length);

  RoundState? round;
  PlayerShip? myShip;
  final remoteShips = <String, RemoteShip>{};
  final bullets = <String, Bullet>{};

  AsteroidField? _asteroidField;
  StormZone? _stormZone;
  int _bulletCounter = 0;
  int _spectateIndex = 0;

  @override
  Future<void> onLoad() async {
    world.add(Starfield());
    camera.setBounds(
      Rectangle.fromRect(
        Rect.fromCenter(
          center: Offset.zero,
          width: GameConfig.worldRadius * 2.4,
          height: GameConfig.worldRadius * 2.4,
        ),
      ),
      considerViewport: true,
    );
    net
      ..onShipState = _onShipState
      ..onShoot = _onShoot
      ..onHit = _onHit
      ..onDeath = _onDeath
      ..onRoundStart = _onRoundStart
      ..onRosterChanged = _onRosterChanged
      ..onPeerLeft = _onPeerLeft;
    await net.connect(_presencePayload());
    overlays.add(OverlayIds.lobby);
  }

  @override
  void update(double dt) {
    super.update(dt);
    final activeRound = round;
    if (phase.value == GamePhase.countdown &&
        activeRound != null &&
        DateTime.now().millisecondsSinceEpoch >= activeRound.startedAt) {
      _setPhase(GamePhase.playing);
    }
  }

  LobbyPresence _presencePayload() {
    return LobbyPresence(
      id: myId,
      name: myName,
      colorIndex: myColorIndex,
      phase: phase.value.name,
      seed: round?.seed,
      startedAt: round?.startedAt,
    );
  }

  Future<void> pushPresence() => net.updatePresence(_presencePayload());

  void setPilot({required String name, required int colorIndex}) {
    myName = name.trim().isEmpty ? myName : name.trim();
    myColorIndex = colorIndex;
    unawaited(pushPresence());
  }

  LobbyPresence? get liveMatch {
    for (final member in roster.value) {
      if (member.inMatch) {
        return member;
      }
    }
    return null;
  }

  void startRound() {
    if (phase.value != GamePhase.lobby) {
      return;
    }
    final ids = <String>{
      myId,
      for (final member in roster.value)
        if (member.phase == GamePhase.lobby.name) member.id,
    }.toList()..sort();
    final payload = RoundStartPayload(
      seed: Random().nextInt(1 << 31),
      startedAt:
          DateTime.now().millisecondsSinceEpoch +
          GameConfig.countdownSeconds * 1000,
      participants: ids,
    );
    net.send(NetEvent.roundStart, payload.toJson());
    _applyRoundStart(payload);
  }

  void spectateLiveMatch() {
    if (phase.value != GamePhase.lobby) {
      return;
    }
    final live = liveMatch;
    if (live == null) {
      return;
    }
    final playingPhases = {GamePhase.countdown.name, GamePhase.playing.name};
    final payload = RoundStartPayload(
      seed: live.seed!,
      startedAt: live.startedAt!,
      participants: [
        for (final member in roster.value)
          if (member.inMatch && playingPhases.contains(member.phase)) member.id,
      ]..sort(),
    );
    _applyRoundStart(payload);
  }

  void _onRoundStart(RoundStartPayload payload) {
    if (phase.value != GamePhase.lobby) {
      return;
    }
    _applyRoundStart(payload);
  }

  void _applyRoundStart(RoundStartPayload payload) {
    _clearWorld();
    final activeRound = RoundState(
      seed: payload.seed,
      startedAt: payload.startedAt,
      participants: List.of(payload.participants)..sort(),
    );
    round = activeRound;
    _asteroidField = AsteroidField(seed: payload.seed);
    _stormZone = StormZone(startedAt: payload.startedAt);
    world.add(_asteroidField!);
    world.add(_stormZone!);
    for (var i = 0; i < activeRound.participants.length; i++) {
      final id = activeRound.participants[i];
      final slotAngle = 2 * pi * i / activeRound.participants.length;
      final spawn = Vector2(cos(slotAngle), sin(slotAngle))
        ..scale(GameConfig.spawnRadius);
      final facing = atan2(-spawn.x, spawn.y);
      final member = _rosterMember(id);
      final name = id == myId ? myName : member?.name ?? 'Pilot';
      final colorIndex = id == myId ? myColorIndex : member?.colorIndex ?? 0;
      final color =
          GameConfig.shipColors[colorIndex % GameConfig.shipColors.length];
      if (id == myId) {
        final ship = PlayerShip(
          playerId: id,
          playerName: name,
          shipColor: color,
          position: spawn,
          angle: facing,
        );
        myShip = ship;
        world.add(ship);
        camera.follow(ship, snap: true);
      } else {
        final ship = RemoteShip(
          playerId: id,
          playerName: name,
          shipColor: color,
          position: spawn,
          angle: facing,
        );
        remoteShips[id] = ship;
        world.add(ship);
      }
    }
    hpNotifier.value = GameConfig.shipMaxHp;
    aliveCount.value = activeRound.alive.length;
    winnerName.value = null;
    if (activeRound.participants.contains(myId)) {
      _setPhase(GamePhase.countdown);
    } else {
      _setPhase(GamePhase.spectating);
      _spectateByIndex(0);
    }
    unawaited(pushPresence());
  }

  LobbyPresence? _rosterMember(String id) {
    for (final member in roster.value) {
      if (member.id == id) {
        return member;
      }
    }
    return null;
  }

  void fireLocalBullet() {
    final ship = myShip;
    if (ship == null) {
      return;
    }
    final bulletId = '$myId-${_bulletCounter++}';
    final bulletDirection = ship.direction;
    final start = ship.position + bulletDirection * (GameConfig.shipRadius + 8);
    _spawnBullet(
      bulletId: bulletId,
      ownerId: myId,
      position: start,
      direction: bulletDirection,
      color: ship.shipColor,
    );
    net.send(
      NetEvent.shoot,
      ShootPayload(
        id: myId,
        bulletId: bulletId,
        x: start.x,
        y: start.y,
        dx: bulletDirection.x,
        dy: bulletDirection.y,
      ).toJson(),
    );
  }

  void _onShoot(ShootPayload payload) {
    final owner = remoteShips[payload.id];
    _spawnBullet(
      bulletId: payload.bulletId,
      ownerId: payload.id,
      position: Vector2(payload.x, payload.y),
      direction: Vector2(payload.dx, payload.dy),
      color: owner?.shipColor ?? const Color(0xFFFFFFFF),
    );
  }

  void _spawnBullet({
    required String bulletId,
    required String ownerId,
    required Vector2 position,
    required Vector2 direction,
    required Color color,
  }) {
    final bullet = Bullet(
      bulletId: bulletId,
      ownerId: ownerId,
      position: position.clone(),
      velocity: direction.normalized()..scale(GameConfig.bulletSpeed),
      color: color,
    );
    bullets[bulletId] = bullet;
    world.add(bullet);
  }

  void removeBullet(String bulletId) {
    bullets.remove(bulletId)?.removeFromParent();
  }

  void _onShipState(ShipStatePayload payload) {
    final ship = remoteShips[payload.id];
    if (ship != null) {
      ship.applyState(payload);
      return;
    }
    final activeRound = round;
    if (activeRound == null || !activeRound.alive.contains(payload.id)) {
      return;
    }
    final member = _rosterMember(payload.id);
    final newShip = RemoteShip(
      playerId: payload.id,
      playerName: member?.name ?? 'Pilot',
      shipColor: GameConfig
          .shipColors[(member?.colorIndex ?? 0) % GameConfig.shipColors.length],
      position: Vector2(payload.x, payload.y),
      angle: payload.rotation,
    );
    remoteShips[payload.id] = newShip;
    world.add(newShip);
  }

  void _onHit(HitPayload payload) {
    removeBullet(payload.bulletId);
    final ship = remoteShips[payload.id];
    if (ship != null) {
      ship
        ..hp = payload.hp
        ..flash();
    }
  }

  void _onDeath(DeathPayload payload) {
    _handleRemoteDeath(payload.id, explode: true);
  }

  void onLocalDeath(String? killerId) {
    final ship = myShip;
    if (ship == null) {
      return;
    }
    net.send(
      NetEvent.death,
      DeathPayload(id: myId, killerId: killerId).toJson(),
    );
    round?.alive.remove(myId);
    world.add(
      Explosion(position: ship.position.clone(), color: ship.shipColor),
    );
    ship.removeFromParent();
    myShip = null;
    aliveCount.value = round?.alive.length ?? 0;
    _setPhase(GamePhase.spectating);
    _spectateByIndex(0);
    unawaited(pushPresence());
    _checkRoundEnd();
  }

  void _onPeerLeft(String id) {
    final ship = remoteShips.remove(id);
    ship?.removeFromParent();
    final activeRound = round;
    if (activeRound != null && activeRound.alive.remove(id)) {
      aliveCount.value = activeRound.alive.length;
      _refreshSpectateTarget();
      _checkRoundEnd();
    }
  }

  void _handleRemoteDeath(String id, {required bool explode}) {
    final activeRound = round;
    if (activeRound == null) {
      return;
    }
    activeRound.alive.remove(id);
    aliveCount.value = activeRound.alive.length;
    final ship = remoteShips.remove(id);
    if (ship != null) {
      if (explode) {
        world.add(
          Explosion(position: ship.position.clone(), color: ship.shipColor),
        );
      }
      ship.removeFromParent();
    }
    _refreshSpectateTarget();
    _checkRoundEnd();
  }

  void _checkRoundEnd() {
    final activeRound = round;
    if (activeRound == null) {
      return;
    }
    if (phase.value == GamePhase.lobby || phase.value == GamePhase.roundOver) {
      return;
    }
    if (activeRound.participants.length < 2) {
      if (activeRound.alive.isNotEmpty) {
        return;
      }
    } else if (activeRound.alive.length > 1) {
      return;
    }
    final winnerId = activeRound.alive.length == 1
        ? activeRound.alive.first
        : null;
    _endRound(winnerId);
  }

  void _endRound(String? winnerId) {
    final activeRound = round;
    if (activeRound == null) {
      return;
    }
    activeRound.winnerId = winnerId;
    if (winnerId == null) {
      winnerName.value = null;
    } else if (winnerId == myId) {
      winnerName.value = myName;
      unawaited(scoreService.recordWin(name: myName));
    } else {
      winnerName.value =
          remoteShips[winnerId]?.playerName ??
          _rosterMember(winnerId)?.name ??
          'Pilot';
    }
    _setPhase(GamePhase.roundOver);
    Future<void>.delayed(
      const Duration(seconds: GameConfig.roundOverSeconds),
      () {
        if (phase.value == GamePhase.roundOver) {
          backToLobby();
        }
      },
    );
  }

  void backToLobby() {
    if (phase.value != GamePhase.roundOver) {
      return;
    }
    _clearWorld();
    round = null;
    _setPhase(GamePhase.lobby);
    unawaited(pushPresence());
  }

  void spectateNext() {
    _spectateByIndex(_spectateIndex + 1);
  }

  void _refreshSpectateTarget() {
    if (phase.value == GamePhase.spectating) {
      _spectateByIndex(_spectateIndex);
    }
  }

  void _spectateByIndex(int index) {
    final targets = remoteShips.values.toList();
    if (targets.isEmpty) {
      spectatingName.value = null;
      camera.stop();
      return;
    }
    _spectateIndex = index % targets.length;
    final target = targets[_spectateIndex];
    spectatingName.value = target.playerName;
    camera.follow(target, snap: false);
  }

  void _onRosterChanged(List<LobbyPresence> members) {
    roster.value = members;
  }

  void _clearWorld() {
    _asteroidField?.removeFromParent();
    _asteroidField = null;
    _stormZone?.removeFromParent();
    _stormZone = null;
    myShip?.removeFromParent();
    myShip = null;
    for (final ship in remoteShips.values) {
      ship.removeFromParent();
    }
    remoteShips.clear();
    for (final bullet in bullets.values) {
      bullet.removeFromParent();
    }
    bullets.clear();
    camera.stop();
    camera.moveTo(Vector2.zero());
    spectatingName.value = null;
    _spectateIndex = 0;
  }

  void _setPhase(GamePhase next) {
    if (phase.value == next) {
      return;
    }
    phase.value = next;
    overlays
      ..removeAll(const [
        OverlayIds.lobby,
        OverlayIds.countdown,
        OverlayIds.hud,
        OverlayIds.spectator,
        OverlayIds.roundOver,
      ])
      ..add(switch (next) {
        GamePhase.lobby => OverlayIds.lobby,
        GamePhase.countdown => OverlayIds.countdown,
        GamePhase.playing => OverlayIds.hud,
        GamePhase.spectating => OverlayIds.spectator,
        GamePhase.roundOver => OverlayIds.roundOver,
      });
  }
}
