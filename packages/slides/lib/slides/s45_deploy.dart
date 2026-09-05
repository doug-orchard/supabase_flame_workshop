import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';

import '../widgets/code_pane.dart';
import '../widgets/side_bullets.dart';

class DeploySlide extends FlutterDeckSlideWidget {
  const DeploySlide()
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/deploy',
          title: 'Shipping it',
          speakerNotes:
              '- Create a hosted Supabase project, push the migration\n'
              '- Enable anonymous sign-ins in the dashboard\n'
              '- flutter build web, host the output anywhere static\n'
              '- Mind the Realtime message limits on the free tier',
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.split(
      leftBuilder: (context) => const SideBullets(
        items: [
          'supabase link and db push for the schema',
          'Enable anonymous sign-ins for the project',
          'Any static host serves the web build',
          'Split rooms to respect Realtime rate limits',
        ],
      ),
      rightBuilder: (context) => const CodePane(
        fileName: 'deploy.sh',
        code: '''
PROJECT=your-project-ref
supabase link --project-ref \$PROJECT
supabase db push

flutter build web \\
  --dart-define=SUPABASE_URL=https://\$PROJECT.supabase.co \\
  --dart-define=SUPABASE_KEY=sb_publishable_... \\
  --dart-define=ROOM=demo

# Deploy build/web to any static host.''',
      ),
    );
  }
}
