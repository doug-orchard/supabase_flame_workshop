import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';

import '../widgets/exercise_panel.dart';

class ExerciseLiftoffSlide extends FlutterDeckSlideWidget {
  const ExerciseLiftoffSlide()
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/exercise-1',
          title: 'Exercise 1: Lift off',
          speakerNotes:
              '- Budget about 15 minutes\n'
              '- Everybody works inside packages/skeleton\n'
              '- Walk around and unblock people\n'
              '- Common snag: anonymous sign-ins not enabled',
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => const ExercisePanel(
        number: 1,
        title: 'Lift off',
        tasks: [
          'Create your free Supabase project and enable anonymous sign-ins',
          'Apply the scores migration to your project',
          'Run packages/skeleton against it with your dart-defines',
          'main.dart: Supabase.initialize, then signInAnonymously',
        ],
        doneWhen: 'The launch pad screen turns green with your user id.',
      ),
    );
  }
}
