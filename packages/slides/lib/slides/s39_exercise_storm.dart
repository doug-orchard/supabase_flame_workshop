import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';

import '../widgets/exercise_panel.dart';

class ExerciseStormSlide extends FlutterDeckSlideWidget {
  const ExerciseStormSlide()
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/exercise-8',
          title: 'Exercise 8: The storm',
          speakerNotes:
              '- Budget about 15 minutes\n'
              '- radiusAt is a pure function of time, no network involved\n'
              '- Test the disconnect path by closing a window mid round',
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => const ExercisePanel(
        number: 8,
        title: 'The shrinking storm',
        tasks: [
          'radiusAt(startedAt, now): grace period, then a linear shrink',
          'Render the safe circle and the storm outside it',
          'Ships outside the radius damage themselves over time',
          'A presence leave removes the ship and counts as a death',
        ],
        doneWhen:
            'Hiding at the edge is fatal, and closing a window ends the '
            'round cleanly.',
      ),
    );
  }
}
