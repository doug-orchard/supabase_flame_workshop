import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';

import '../widgets/code_pane.dart';
import '../widgets/side_bullets.dart';

class SetupSlide extends FlutterDeckSlideWidget {
  const SetupSlide()
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/setup',
          title: 'Setting up',
          speakerNotes:
              '- Walk through creating a free project at database.new, pick '
              'a region close to the room\n'
              '- Enable anonymous sign-ins under Authentication settings, '
              'the game signs everyone in anonymously\n'
              '- Fork the workshop repository, we connect your fork to '
              'Supabase on the next slide\n'
              '- The repository carries the migration and all the reference '
              'code, so nothing is copied by hand',
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.split(
      leftBuilder: (context) => const SideBullets(
        items: [
          'Create a free project at database.new',
          'Enable anonymous sign-ins under Authentication',
          'Fork the workshop repository on GitHub',
          'Clone your fork and fetch the dependencies',
        ],
      ),
      rightBuilder: (context) => const CodePane(
        fileName: 'setup.sh',
        code: '''
git clone \\
    https://github.com/your-name/supabase_flame_workshop
cd supabase_flame_workshop
dart pub get

# What the repository already holds:
#   supabase/migrations/  the scores table
#   packages/skeleton/    where you build
#   packages/game/        the finished reference''',
      ),
    );
  }
}
