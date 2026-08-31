import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';

import '../widgets/side_bullets.dart';

class StretchSlide extends FlutterDeckSlideWidget {
  const StretchSlide()
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/stretch',
          title: 'Where to take it next',
          speakerNotes:
              '- Ideas for after the workshop\n'
              '- The farm-proof leaderboard mirrors what production games '
              'need: move trust into Postgres functions',
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => const SideBullets(
        items: [
          'Mouse aim and touch controls',
          'Sound effects and a shader starfield',
          'Powerups from the shared seed',
          'A farm-proof leaderboard: SECURITY DEFINER function with a vote',
          'Private channels with Realtime authorization',
        ],
      ),
    );
  }
}
