import 'dart:math';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../db/score_service.dart';
import '../game/space_game.dart';
import '../net/net_service.dart';
import '../ui/countdown_overlay.dart';
import '../ui/hud_overlay.dart';
import '../ui/lobby_overlay.dart';
import '../ui/round_over_overlay.dart';
import '../ui/spectator_overlay.dart';
import 'overlay_ids.dart';

class GameApp extends StatefulWidget {
  const GameApp({super.key});

  @override
  State<GameApp> createState() => _GameAppState();
}

class _GameAppState extends State<GameApp> {
  late final SpaceGame game;

  @override
  void initState() {
    super.initState();
    final client = Supabase.instance.client;
    final random = Random();
    final myId = [
      for (var i = 0; i < 16; i++) random.nextInt(16).toRadixString(16),
    ].join();
    game = SpaceGame(
      net: NetService(myId: myId),
      myId: myId,
      scoreService: ScoreService(client),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nebula Standoff',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: Scaffold(
        backgroundColor: const Color(0xFF07070F),
        body: GameWidget<SpaceGame>(
          game: game,
          overlayBuilderMap: {
            OverlayIds.lobby: (context, game) => LobbyOverlay(game: game),
            OverlayIds.countdown: (context, game) =>
                CountdownOverlay(game: game),
            OverlayIds.hud: (context, game) => HudOverlay(game: game),
            OverlayIds.spectator: (context, game) =>
                SpectatorOverlay(game: game),
            OverlayIds.roundOver: (context, game) =>
                RoundOverOverlay(game: game),
          },
        ),
      ),
    );
  }
}
