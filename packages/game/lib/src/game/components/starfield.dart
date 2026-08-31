import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';

import '../../game_config.dart';

class Starfield extends PositionComponent {
  Starfield() : super(priority: -20);

  static final List<(Offset, double, double)> _stars = () {
    final random = Random(7);
    return [
      for (var i = 0; i < 400; i++)
        (
          Offset(
            (random.nextDouble() * 2 - 1) * GameConfig.worldRadius * 1.6,
            (random.nextDouble() * 2 - 1) * GameConfig.worldRadius * 1.6,
          ),
          0.5 + random.nextDouble() * 1.3,
          0.3 + random.nextDouble() * 0.7,
        ),
    ];
  }();

  @override
  void render(Canvas canvas) {
    for (final (offset, starRadius, alpha) in _stars) {
      canvas.drawCircle(
        offset,
        starRadius,
        Paint()..color = Color.fromRGBO(255, 255, 255, alpha),
      );
    }
  }
}
