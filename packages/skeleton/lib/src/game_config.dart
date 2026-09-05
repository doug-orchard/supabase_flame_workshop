import 'package:flutter/material.dart';

class GameConfig {
  static const worldRadius = 900.0;

  static const shipMaxSpeed = 240.0;
  static const shipAcceleration = 320.0;
  static const shipBrake = 480.0;
  static const shipDrag = 0.6;
  static const shipRotationSpeed = 3.5;
  static const shipMaxHp = 100.0;
  static const shipRadius = 14.0;

  static const fireCooldown = 0.25;
  static const bulletSpeed = 420.0;
  static const bulletTtl = 1.4;
  static const bulletDamage = 15.0;
  static const asteroidBumpDamage = 5.0;

  static const stateSyncInterval = 0.05;
  static const keepaliveInterval = 1.0;
  static const remoteLerpFactorPerSecond = 12.0;
  static const remoteTeleportDistance = 200.0;

  static const zoneGraceSeconds = 20.0;
  static const zoneShrinkSeconds = 90.0;
  static const zoneMinRadius = 120.0;
  static const zoneDamagePerSecond = 10.0;

  static const asteroidCount = 60;
  static const spawnRadius = 600.0;

  static const countdownSeconds = 3;
  static const roundOverSeconds = 6;

  static const shipColors = [
    Color(0xFF4FC3F7),
    Color(0xFFFF8A65),
    Color(0xFFAED581),
    Color(0xFFBA68C8),
    Color(0xFFFFD54F),
    Color(0xFFF06292),
    Color(0xFF4DB6AC),
    Color(0xFF90A4AE),
  ];
}
