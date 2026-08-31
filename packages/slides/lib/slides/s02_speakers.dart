import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class SpeakersSlide extends FlutterDeckSlideWidget {
  const SpeakersSlide()
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/speakers',
          title: 'Your host',
          speakerNotes:
              '- Introduce yourself\n'
              '- Both hats today: Flame core maintainer and Supabase SDK '
              'engineer',
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => const Center(
        child: SpeakerCard(
          name: 'Lukas Klingsbo',
          role: 'Flame core maintainer · Supabase SDK engineer',
          handle: '@spydon',
        ),
      ),
    );
  }
}

class SpeakerCard extends StatelessWidget {
  const SpeakerCard({
    required this.name,
    required this.role,
    required this.handle,
    super.key,
  });

  final String name;
  final String role;
  final String handle;

  @override
  Widget build(BuildContext context) {
    final textTheme = FlutterDeckTheme.of(context).textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.person, size: 120),
        const SizedBox(height: 16),
        Text(name, style: textTheme.title),
        const SizedBox(height: 8),
        Text(role, style: textTheme.bodyMedium),
        const SizedBox(height: 4),
        Text(handle, style: textTheme.bodySmall),
      ],
    );
  }
}
