import 'package:flutter/material.dart';

import '../game/space_game.dart';

class SpectatorOverlay extends StatelessWidget {
  const SpectatorOverlay({required this.game, super.key});

  final SpaceGame game;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: const Color(0xAA07070F),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.visibility, size: 18),
                const SizedBox(width: 8),
                ValueListenableBuilder<String?>(
                  valueListenable: game.spectatingName,
                  builder: (context, name, _) =>
                      Text(name == null ? 'Spectating' : 'Spectating $name'),
                ),
                const SizedBox(width: 12),
                ValueListenableBuilder<int>(
                  valueListenable: game.aliveCount,
                  builder: (context, alive, _) => Text(
                    '$alive left',
                    style: const TextStyle(color: Colors.white54),
                  ),
                ),
                const SizedBox(width: 12),
                TextButton(
                  onPressed: game.spectateNext,
                  child: const Text('Next ship'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
