import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class SideBullets extends StatelessWidget {
  const SideBullets({required this.items, this.useSteps = false, super.key});

  final List<String> items;
  final bool useSteps;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: FlutterDeckBulletList(items: items, useSteps: useSteps),
      ),
    );
  }
}
