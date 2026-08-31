import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Asteroid extends PositionComponent {
  Asteroid({
    required super.position,
    required this.radius,
    required this.vertices,
    required super.angle,
  }) : super(size: Vector2.all(radius * 2), anchor: Anchor.center);

  final double radius;
  final List<Vector2> vertices;

  late final Path _outline = () {
    final path = Path();
    for (var i = 0; i < vertices.length; i++) {
      final vertex = vertices[i] + size / 2;
      if (i == 0) {
        path.moveTo(vertex.x, vertex.y);
      } else {
        path.lineTo(vertex.x, vertex.y);
      }
    }
    path.close();
    return path;
  }();

  @override
  void onLoad() {
    add(
      CircleHitbox(
        radius: radius * 0.8,
        position: size / 2,
        anchor: Anchor.center,
      ),
    );
  }

  @override
  void render(Canvas canvas) {
    canvas.drawPath(_outline, Paint()..color = const Color(0xFF4A4A55));
    canvas.drawPath(
      _outline,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5
        ..color = const Color(0xFF7A7A88),
    );
  }
}
