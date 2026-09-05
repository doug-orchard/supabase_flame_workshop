import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';

import '../widgets/code_pane.dart';
import '../widgets/side_bullets.dart';

class ZoneSlide extends FlutterDeckSlideWidget {
  const ZoneSlide()
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/zone',
          title: 'The shrinking storm zone',
          speakerNotes:
              '- Pure function of time since startedAt\n'
              '- Every client computes the same radius every frame\n'
              '- Outside the circle you take damage: rounds always end',
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.split(
      leftBuilder: (context) => const SideBullets(
        items: [
          'radiusAt(startedAt, now): a pure function',
          'Grace period, then a linear shrink',
          'Zone damage is applied by each ship to itself',
          'Zero network traffic for the zone',
        ],
      ),
      rightBuilder: (context) => const CodePane(
        fileName: 'packages/game/lib/src/game/components/storm_zone.dart',
        code: '''
static double radiusAt(int startedAt, int nowMs) {
  final elapsed = (nowMs - startedAt) / 1000;
  if (elapsed < GameConfig.zoneGraceSeconds) {
    return GameConfig.worldRadius;
  }
  final progress =
      ((elapsed - GameConfig.zoneGraceSeconds) /
              GameConfig.zoneShrinkSeconds)
          .clamp(0.0, 1.0);
  return GameConfig.worldRadius +
      (GameConfig.zoneMinRadius - GameConfig.worldRadius) *
          progress;
}''',
      ),
    );
  }
}
