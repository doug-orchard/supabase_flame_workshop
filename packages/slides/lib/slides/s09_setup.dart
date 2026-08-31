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
              '- Walk through creating a free project at database.new\n'
              '- Enable anonymous sign-ins under Authentication settings\n'
              '- The workshop repository carries the migration and all the '
              'reference code\n'
              '- The publishable key is on the project API settings page',
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.split(
      leftBuilder: (context) => const SideBullets(
        items: [
          'Create a free project at database.new',
          'Enable anonymous sign-ins under Authentication',
          'Clone the workshop repository',
          'Push the scores migration to your project',
          'Point the game at your project with dart-defines',
        ],
      ),
      rightBuilder: (context) => const CodePane(
        fileName: 'setup.sh',
        code: '''
git clone \\
    https://github.com/spydon/supabase_flame_workshop
cd supabase_flame_workshop
dart pub get

supabase link --project-ref your-ref
supabase db push

cd packages/game
flutter run -d chrome \\
  --dart-define=SUPABASE_URL=... \\
  --dart-define=SUPABASE_KEY=sb_publishable_...''',
      ),
    );
  }
}
