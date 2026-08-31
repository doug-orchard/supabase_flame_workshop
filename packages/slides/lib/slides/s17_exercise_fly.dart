import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';

import '../widgets/exercise_panel.dart';

class ExerciseFlySlide extends FlutterDeckSlideWidget {
  const ExerciseFlySlide()
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/exercise-2',
          title: 'Exercise 2: Fly your ship',
          speakerNotes:
              '- Budget about 20 minutes\n'
              '- The reference ship lives in components/player_ship.dart\n'
              '- Nudge people toward dt everywhere in the physics',
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => const ExercisePanel(
        number: 2,
        title: 'Fly your ship',
        tasks: [
          'SpaceGame in a GameWidget, with a starfield behind everything',
          'A ship component: triangle hull, thrust, turn, drag, speed cap',
          'Keyboard flags through KeyboardHandler, space fires bullets',
          'Camera: fixed 960 by 540 resolution, following your ship',
        ],
        doneWhen: 'You can swoop around and shoot into the void.',
      ),
    );
  }
}
