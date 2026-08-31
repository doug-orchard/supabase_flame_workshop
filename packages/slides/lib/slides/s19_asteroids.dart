import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';

import '../widgets/code_pane.dart';
import '../widgets/side_bullets.dart';

class AsteroidsSlide extends FlutterDeckSlideWidget {
  const AsteroidsSlide()
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/asteroids',
          title: 'An asteroid field from one integer',
          speakerNotes:
              '- Random(seed) is deterministic across platforms\n'
              '- Same iteration order means byte-identical fields\n'
              '- Rejection sampling keeps spawn slots clear',
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.split(
      leftBuilder: (context) => const SideBullets(
        items: [
          'Random(seed) yields the same sequence everywhere',
          'Fixed iteration order, no local state',
          'Reject positions near the spawn ring',
        ],
      ),
      rightBuilder: (context) => const CodePane(
        fileName: 'packages/game/lib/src/game/components/asteroid_field.dart',
        code: '''
final random = Random(seed);
while (placed < GameConfig.asteroidCount) {
  final distance = 150 +
      random.nextDouble() * (GameConfig.worldRadius - 180);
  final direction = random.nextDouble() * 2 * pi;
  if ((distance - GameConfig.spawnRadius).abs() < 80) {
    continue;
  }
  final radius = 16 + random.nextDouble() * 32;
  add(Asteroid(position: position, radius: radius, ...));
  placed++;
}''',
      ),
    );
  }
}
