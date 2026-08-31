import 'package:flutter/material.dart';

import '../../game_config.dart';
import '../../net/payloads/lobby_presence.dart';

class PlayerList extends StatelessWidget {
  const PlayerList({required this.members, required this.myId, super.key});

  final List<LobbyPresence> members;
  final String myId;

  @override
  Widget build(BuildContext context) {
    final sorted = List.of(members)..sort((a, b) => a.name.compareTo(b.name));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Pilots online', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        for (final member in sorted)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.rocket_launch,
                  size: 16,
                  color:
                      GameConfig.shipColors[member.colorIndex %
                          GameConfig.shipColors.length],
                ),
                const SizedBox(width: 8),
                Text(member.id == myId ? '${member.name} (you)' : member.name),
                const SizedBox(width: 8),
                Text(
                  member.inMatch ? 'in match' : member.phase,
                  style: const TextStyle(color: Colors.white38, fontSize: 12),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
