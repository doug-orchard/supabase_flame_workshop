import 'dart:async';

import 'package:flutter/material.dart';

import '../game/space_game.dart';

class CountdownOverlay extends StatefulWidget {
  const CountdownOverlay({required this.game, super.key});

  final SpaceGame game;

  @override
  State<CountdownOverlay> createState() => _CountdownOverlayState();
}

class _CountdownOverlayState extends State<CountdownOverlay> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final startedAt = widget.game.round?.startedAt ?? 0;
    final remainingMs = startedAt - DateTime.now().millisecondsSinceEpoch;
    final seconds = (remainingMs / 1000).ceil().clamp(0, 9);
    return IgnorePointer(
      child: Center(
        child: Text(
          seconds > 0 ? '$seconds' : 'Fight!',
          style: const TextStyle(
            fontSize: 96,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [Shadow(blurRadius: 24, color: Colors.blueAccent)],
          ),
        ),
      ),
    );
  }
}
