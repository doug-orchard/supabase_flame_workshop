import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';

import '../widgets/code_pane.dart';
import '../widgets/side_bullets.dart';

class RunTheGameSlide extends FlutterDeckSlideWidget {
  const RunTheGameSlide()
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/run-the-game',
          title: 'Running the skeleton',
          speakerNotes:
              '- The project URL and the publishable key are on the project '
              'API settings page\n'
              '- The key is publishable on purpose, it ships in the client '
              'and row level security guards the data\n'
              '- Both values reach the app as dart-defines, no secrets in '
              'the repository\n'
              '- Run the command twice to play against yourself\n'
              '- ROOM decides who meets whom, split the room into groups to '
              'stay under the Realtime limits\n'
              '- Prefer a local stack? supabase start and the defaults '
              'already point there',
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.split(
      leftBuilder: (context) => const SideBullets(
        items: [
          'Copy the project URL and publishable key from the API settings',
          'Pass both to the skeleton as dart-defines',
          'ROOM decides which arena you join',
          'Run it twice to play against yourself',
        ],
      ),
      rightBuilder: (context) => const CodePane(
        fileName: 'run.sh',
        code: '''
cd packages/skeleton
flutter run -d chrome \\
  --dart-define=SUPABASE_URL=https://your-ref.supabase.co \\
  --dart-define=SUPABASE_KEY=sb_publishable_... \\
  --dart-define=ROOM=main

# Or run everything locally instead:
supabase start
melos run skeleton''',
      ),
    );
  }
}
