import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';

class WhyServerlessSlide extends FlutterDeckSlideWidget {
  const WhyServerlessSlide()
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/why-serverless',
          title: 'Why serverless multiplayer',
          speakerNotes:
              '- Traditional multiplayer: dedicated servers, WebSocket state '
              'machines, matchmaking infrastructure\n'
              '- Supabase Realtime gives us a message bus and presence out of '
              'the box\n'
              '- The clients themselves run the game logic',
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.bigFact(
      title: '0 game servers',
      subtitle:
          'The whole netcode is Supabase Realtime: '
          'Broadcast for events, Presence for who is online.',
    );
  }
}
