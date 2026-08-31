import 'dart:async';

import 'package:flutter/material.dart';

import '../game/components/storm_zone.dart';
import '../game/space_game.dart';
import '../game_config.dart';
import 'widgets/health_bar.dart';

class HudOverlay extends StatefulWidget {
  const HudOverlay({required this.game, super.key});

  final SpaceGame game;

  @override
  State<HudOverlay> createState() => _HudOverlayState();
}

class _HudOverlayState extends State<HudOverlay> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _zoneLabel() {
    final round = widget.game.round;
    if (round == null) {
      return '';
    }
    final now = DateTime.now().millisecondsSinceEpoch;
    final graceEndsAt =
        round.startedAt + GameConfig.zoneGraceSeconds.toInt() * 1000;
    if (now < graceEndsAt) {
      final seconds = ((graceEndsAt - now) / 1000).ceil();
      return 'Storm closes in $seconds s';
    }
    final radius = StormZone.radiusAt(round.startedAt, now);
    if (radius <= GameConfig.zoneMinRadius) {
      return 'Storm fully closed';
    }
    return 'Storm closing: safe radius ${radius.round()}';
  }

  @override
  Widget build(BuildContext context) {
    final game = widget.game;
    return IgnorePointer(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ValueListenableBuilder<double>(
                  valueListenable: game.hpNotifier,
                  builder: (context, hp, _) => HealthBar(hp: hp),
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ValueListenableBuilder<int>(
                      valueListenable: game.aliveCount,
                      builder: (context, alive, _) => Text(
                        '$alive ships remaining',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _zoneLabel(),
                      style: const TextStyle(color: Colors.redAccent),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
