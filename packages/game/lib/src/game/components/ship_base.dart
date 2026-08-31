import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

import '../../game_config.dart';

abstract class ShipBase extends PositionComponent {
  ShipBase({
    required this.playerId,
    required this.playerName,
    required this.shipColor,
    required super.position,
    super.angle,
  }) : super(
         size: Vector2.all(GameConfig.shipRadius * 2),
         anchor: Anchor.center,
         priority: 10,
       );

  final String playerId;
  final String playerName;
  final Color shipColor;

  double hp = GameConfig.shipMaxHp;
  double _flashTime = 0;

  Vector2 get direction => Vector2(sin(angle), -cos(angle));

  late final Path _hull = Path()
    ..moveTo(size.x / 2, 0)
    ..lineTo(size.x * 0.9, size.y)
    ..lineTo(size.x / 2, size.y * 0.72)
    ..lineTo(size.x * 0.1, size.y)
    ..close();

  @override
  void onLoad() {
    add(ShipTag());
  }

  void flash() {
    _flashTime = 0.15;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_flashTime > 0) {
      _flashTime -= dt;
    }
  }

  @override
  void render(Canvas canvas) {
    final fill = Paint()
      ..color = _flashTime > 0 ? const Color(0xFFFFFFFF) : shipColor;
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = const Color(0xCCFFFFFF);
    canvas.drawPath(_hull, fill);
    canvas.drawPath(_hull, stroke);
  }
}

class ShipTag extends PositionComponent {
  ShipTag() : super(anchor: Anchor.center);

  static final _textPaint = TextPaint(
    style: const TextStyle(color: Color(0xCCFFFFFF), fontSize: 10),
  );

  ShipBase get ship => parent! as ShipBase;

  @override
  void onMount() {
    super.onMount();
    position = ship.size / 2;
  }

  @override
  void update(double dt) {
    angle = -ship.angle;
  }

  @override
  void render(Canvas canvas) {
    _textPaint.render(
      canvas,
      ship.playerName,
      Vector2(0, -ship.size.y / 2 - 18),
      anchor: Anchor.bottomCenter,
    );
    final ratio = (ship.hp / GameConfig.shipMaxHp).clamp(0.0, 1.0);
    const barWidth = 28.0;
    final barTop = -ship.size.y / 2 - 16;
    canvas.drawRect(
      Rect.fromLTWH(-barWidth / 2, barTop, barWidth, 3),
      Paint()..color = const Color(0x55FFFFFF),
    );
    canvas.drawRect(
      Rect.fromLTWH(-barWidth / 2, barTop, barWidth * ratio, 3),
      Paint()
        ..color = ratio > 0.3
            ? const Color(0xFF66DD66)
            : const Color(0xFFDD5555),
    );
  }
}
