import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/particles.dart';

class Explosion extends ParticleSystemComponent {
  Explosion({required Vector2 position, required Color color})
    : super(position: position, priority: 15, particle: _burst(color));

  static Particle _burst(Color color) {
    final random = Random();
    return Particle.generate(
      count: 24,
      lifespan: 0.9,
      generator: (index) {
        final direction = random.nextDouble() * 2 * pi;
        final speed = 40 + random.nextDouble() * 140;
        return AcceleratedParticle(
          speed: Vector2(cos(direction), sin(direction))..scale(speed),
          child: ComputedParticle(
            renderer: (canvas, particle) {
              canvas.drawCircle(
                Offset.zero,
                2 + random.nextDouble() * 2,
                Paint()..color = color.withValues(alpha: 1 - particle.progress),
              );
            },
          ),
        );
      },
    );
  }
}
