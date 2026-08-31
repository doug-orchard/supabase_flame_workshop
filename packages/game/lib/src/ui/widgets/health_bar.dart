import 'package:flutter/material.dart';

import '../../game_config.dart';

class HealthBar extends StatelessWidget {
  const HealthBar({required this.hp, super.key});

  final double hp;

  @override
  Widget build(BuildContext context) {
    final ratio = (hp / GameConfig.shipMaxHp).clamp(0.0, 1.0);
    return SizedBox(
      width: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Hull ${hp.ceil().clamp(0, 100)}'),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: ratio,
              minHeight: 10,
              backgroundColor: Colors.white12,
              color: ratio > 0.3 ? Colors.greenAccent : Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }
}
