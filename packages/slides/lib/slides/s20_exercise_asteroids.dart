import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';

import '../widgets/exercise_panel.dart';

class ExerciseAsteroidsSlide extends FlutterDeckSlideWidget {
  const ExerciseAsteroidsSlide()
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/exercise-3',
          title: 'Exercise 3: Asteroid field',
          speakerNotes:
              '- Budget about 15 minutes\n'
              '- Determinism check: restart with the same seed and compare '
              'screens with a neighbor',
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => const ExercisePanel(
        number: 3,
        title: 'An asteroid field from one integer',
        tasks: [
          'AsteroidField(seed): Random(seed), polar placement, jittered '
              'polygon rocks',
          'Keep the spawn ring clear with rejection sampling',
          'Circle hitboxes: bullets stop, ships bounce with bump damage',
        ],
        doneWhen:
            'The same seed produces the same field on every restart, and on '
            'your neighbor\'s machine.',
      ),
    );
  }
}
