import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';

import '../widgets/exercise_panel.dart';

class ExerciseSyncSlide extends FlutterDeckSlideWidget {
  const ExerciseSyncSlide()
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/exercise-5',
          title: 'Exercise 5: See each other fly',
          speakerNotes:
              '- Budget about 20 minutes\n'
              '- The dead reckoning factor min(1, dt * 12) is the magic\n'
              '- If remote ships stutter, check they advance by velocity '
              'every frame, not only on packets',
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => const ExercisePanel(
        number: 5,
        title: 'See each other fly',
        tasks: [
          'Broadcast your ship state at 20 Hz, skipping idle frames',
          'A RemoteShip that dead-reckons and eases toward the target',
          'Spawn remote bullets from shoot events by their bulletId',
        ],
        doneWhen:
            'Two windows show both ships flying smoothly, not teleporting.',
      ),
    );
  }
}
