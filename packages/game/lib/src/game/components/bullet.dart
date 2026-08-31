import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../../game_config.dart';
import '../space_game.dart';
import 'asteroid.dart';

class Bullet extends PositionComponent
    with HasGameReference<SpaceGame>, CollisionCallbacks {
  Bullet({
    required this.bulletId,
    required this.ownerId,
    required super.position,
    required this.velocity,
    required this.color,
  }) : super(size: Vector2.all(6), anchor: Anchor.center, priority: 5);

  final String bulletId;
  final String ownerId;
  final Vector2 velocity;
  final Color color;

  double _ttl = GameConfig.bulletTtl;

  @override
  void onLoad() {
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    position.add(velocity * dt);
    _ttl -= dt;
    if (_ttl <= 0) {
      game.removeBullet(bulletId);
    }
  }

  @override
  void render(Canvas canvas) {
    final center = (size / 2).toOffset();
    canvas.drawCircle(center, 5, Paint()..color = color.withValues(alpha: 0.3));
    canvas.drawCircle(center, 2.5, Paint()..color = color);
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Asteroid) {
      game.removeBullet(bulletId);
    }
  }
}
