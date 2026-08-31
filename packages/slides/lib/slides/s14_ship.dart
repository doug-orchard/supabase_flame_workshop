import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';

import '../widgets/code_pane.dart';
import '../widgets/side_bullets.dart';

class ShipSlide extends FlutterDeckSlideWidget {
  const ShipSlide()
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/ship',
          title: 'Building the ship',
          speakerNotes:
              '- Thrust accelerates along the nose direction\n'
              '- Drag and a speed cap keep it controllable\n'
              '- The same base class renders local and remote ships',
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.split(
      leftBuilder: (context) => const SideBullets(
        items: [
          'Velocity integration in update',
          'Thrust along the nose, drag against motion',
          'Speed cap keeps the arena fair',
        ],
      ),
      rightBuilder: (context) => const CodePane(
        fileName: 'packages/game/lib/src/game/components/player_ship.dart',
        code: '''
void _integrate(double dt) {
  final turn = (_right ? 1 : 0) - (_left ? 1 : 0);
  angle += turn * GameConfig.shipRotationSpeed * dt;
  if (_thrust) {
    velocity.add(
      direction * GameConfig.shipAcceleration * dt,
    );
  }
  velocity.scale(1 - GameConfig.shipDrag * dt);
  if (velocity.length > GameConfig.shipMaxSpeed) {
    velocity.scaleTo(GameConfig.shipMaxSpeed);
  }
  position.add(velocity * dt);
}''',
      ),
    );
  }
}
