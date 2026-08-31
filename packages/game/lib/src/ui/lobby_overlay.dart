import 'package:flutter/material.dart';

import '../db/supabase_schema.g.dart';
import '../game_config.dart';
import '../game/space_game.dart';
import '../net/payloads/lobby_presence.dart';
import 'widgets/player_list.dart';

class LobbyOverlay extends StatefulWidget {
  const LobbyOverlay({required this.game, super.key});

  final SpaceGame game;

  @override
  State<LobbyOverlay> createState() => _LobbyOverlayState();
}

class _LobbyOverlayState extends State<LobbyOverlay> {
  late final TextEditingController _nameController;
  late int _colorIndex;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.game.myName);
    _colorIndex = widget.game.myColorIndex;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _apply() {
    widget.game.setPilot(name: _nameController.text, colorIndex: _colorIndex);
  }

  @override
  Widget build(BuildContext context) {
    final game = widget.game;
    return ColoredBox(
      color: const Color(0xCC07070F),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 820),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nebula Standoff',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Last ship standing wins the round.',
                      style: TextStyle(color: Colors.white54),
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: _nameController,
                      maxLength: 16,
                      decoration: const InputDecoration(
                        labelText: 'Pilot name',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (_) => _apply(),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      children: [
                        for (var i = 0; i < GameConfig.shipColors.length; i++)
                          ColorSwatchButton(
                            color: GameConfig.shipColors[i],
                            selected: i == _colorIndex,
                            onTap: () {
                              setState(() => _colorIndex = i);
                              _apply();
                            },
                          ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    ValueListenableBuilder<List<LobbyPresence>>(
                      valueListenable: game.roster,
                      builder: (context, roster, _) {
                        final live = game.liveMatch;
                        return Row(
                          children: [
                            FilledButton.icon(
                              onPressed: live == null
                                  ? () {
                                      _apply();
                                      game.startRound();
                                    }
                                  : null,
                              icon: const Icon(Icons.rocket_launch),
                              label: const Text('Launch round'),
                            ),
                            const SizedBox(width: 12),
                            if (live != null)
                              OutlinedButton.icon(
                                onPressed: game.spectateLiveMatch,
                                icon: const Icon(Icons.visibility),
                                label: const Text('Spectate live match'),
                              ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Steer with WASD or arrow keys, fire with space.',
                      style: TextStyle(color: Colors.white38, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 48),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ValueListenableBuilder<List<LobbyPresence>>(
                    valueListenable: game.roster,
                    builder: (context, roster, _) =>
                        PlayerList(members: roster, myId: game.myId),
                  ),
                  const SizedBox(height: 24),
                  Leaderboard(game: game),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ColorSwatchButton extends StatelessWidget {
  const ColorSwatchButton({
    required this.color,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final Color color;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: selected ? Colors.white : Colors.transparent,
            width: 2.5,
          ),
        ),
      ),
    );
  }
}

class Leaderboard extends StatefulWidget {
  const Leaderboard({required this.game, super.key});

  final SpaceGame game;

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  late final Stream<List<ScoresRow>> _scores;

  @override
  void initState() {
    super.initState();
    _scores = widget.game.scoreService.topScores();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ScoresRow>>(
      stream: _scores,
      builder: (context, snapshot) {
        final scores = snapshot.data ?? const [];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Leaderboard', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            if (scores.isEmpty)
              const Text(
                'No wins recorded yet.',
                style: TextStyle(color: Colors.white38),
              ),
            for (final row in scores)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.emoji_events,
                      size: 16,
                      color: Colors.amber,
                    ),
                    const SizedBox(width: 8),
                    Text(row.name),
                    const SizedBox(width: 8),
                    Text(
                      '${row.wins}',
                      style: const TextStyle(color: Colors.white54),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}
