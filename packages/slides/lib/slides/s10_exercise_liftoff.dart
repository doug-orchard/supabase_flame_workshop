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
          'Create a Flutter app and add flame plus supabase_flutter, with '
              'the v3 git overrides from the workshop repository README',
          'Apply the scores migration to your project',
          'main.dart: Supabase.initialize, then signInAnonymously',
        ],
        doneWhen: 'Your app runs and holds a signed-in anonymous user.',
      ),
    );
  }
}
