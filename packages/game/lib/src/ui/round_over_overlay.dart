import 'package:flutter/material.dart';

import '../game/space_game.dart';

class RoundOverOverlay extends StatelessWidget {
  const RoundOverOverlay({required this.game, super.key});

  final SpaceGame game;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xAA07070F),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ValueListenableBuilder<String?>(
              valueListenable: game.winnerName,
              builder: (context, winner, _) => Text(
                winner == null
                    ? 'Draw. The storm wins.'
                    : '$winner wins the round!',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: game.backToLobby,
              child: const Text('Back to lobby'),
            ),
          ],
        ),
      ),
    );
  }
}
