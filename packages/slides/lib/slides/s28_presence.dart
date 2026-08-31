import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';

import '../widgets/code_pane.dart';
import '../widgets/side_bullets.dart';

class PresenceSlide extends FlutterDeckSlideWidget {
  const PresenceSlide()
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/presence',
          title: 'A lobby with Presence',
          speakerNotes:
              '- track() publishes our payload to everyone\n'
              '- presenceState() is the merged roster, always consistent\n'
              '- Presence doubles as match discovery: in-match players carry '
              'seed and startedAt, so late joiners can spectate',
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.split(
      leftBuilder: (context) => const SideBullets(
        items: [
          'track() publishes name, color, and phase',
          'sync, join, leave keep the roster fresh',
          'In-match players advertise seed and startedAt',
          'Late joiners bootstrap straight into spectating',
        ],
      ),
      rightBuilder: (context) => const CodePane(
        fileName: 'packages/game/lib/src/net/net_service.dart',
        code: '''
await channel.track({
  'id': myId,
  'name': myName,
  'color': myColorIndex,
  'phase': phase.value.name,
  'seed': round?.seed,
  'startedAt': round?.startedAt,
});

channel.onPresenceSync.listen((_) {
  final roster = channel.presenceState();
  // Rebuild the lobby list from the merged state.
});''',
      ),
    );
  }
}
