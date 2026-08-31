import 'dart:math';

import 'package:flame/components.dart';

import '../../game_config.dart';
import 'asteroid.dart';

class AsteroidField extends Component {
  AsteroidField({required this.seed});

  final int seed;

  @override
  void onLoad() {
    final random = Random(seed);
    var placed = 0;
    var attempts = 0;
    while (placed < GameConfig.asteroidCount && attempts < 5000) {
      attempts++;
      final distance =
          150 + random.nextDouble() * (GameConfig.worldRadius - 180);
      final direction = random.nextDouble() * 2 * pi;
      final position = Vector2(cos(direction), sin(direction))..scale(distance);
      if ((distance - GameConfig.spawnRadius).abs() < 80) {
        continue;
      }
      final radius = 16 + random.nextDouble() * 32;
      final vertexCount = 8 + random.nextInt(4);
      final vertices = [
        for (var i = 0; i < vertexCount; i++)
          Vector2(cos(2 * pi * i / vertexCount), sin(2 * pi * i / vertexCount))
            ..scale(radius * (0.75 + random.nextDouble() * 0.25)),
      ];
      add(
        Asteroid(
          position: position,
          radius: radius,
          vertices: vertices,
          angle: random.nextDouble() * 2 * pi,
        ),
      );
      placed++;
    }
  }
}
