import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class ExercisePanel extends StatelessWidget {
  const ExercisePanel({
    required this.number,
    required this.title,
    required this.tasks,
    required this.doneWhen,
    super.key,
  });

  static const green = Color(0xFF3ECF8E);

  final int number;
  final String title;
  final List<String> tasks;
  final String doneWhen;

  @override
  Widget build(BuildContext context) {
    final textTheme = FlutterDeckTheme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.all(48),
      padding: const EdgeInsets.all(48),
      decoration: BoxDecoration(
        border: Border.all(color: green, width: 3),
        borderRadius: BorderRadius.circular(24),
        color: green.withValues(alpha: 0.06),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.handyman, color: green, size: 44),
              const SizedBox(width: 16),
              Text(
                'Exercise $number · build time',
                style: textTheme.bodyMedium.copyWith(color: green),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(title, style: textTheme.title),
          const SizedBox(height: 28),
          for (final task in tasks)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.check_box_outline_blank, size: 28),
                  const SizedBox(width: 16),
                  Expanded(child: Text(task, style: textTheme.bodyMedium)),
                ],
              ),
            ),
          const Spacer(),
          Text(
            'Done when: $doneWhen',
            style: textTheme.bodyMedium.copyWith(color: green),
          ),
          const SizedBox(height: 8),
          Text(
            'Falling behind? The finished game in packages/game is your '
            'reference.',
            style: textTheme.bodySmall.copyWith(color: Colors.white54),
          ),
        ],
      ),
    );
  }
}
