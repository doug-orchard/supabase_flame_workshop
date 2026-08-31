import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';

class TitleSlide extends FlutterDeckSlideWidget {
  const TitleSlide()
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/title',
          title: 'Title',
          speakerNotes:
              '- Welcome everyone\n'
              '- Today we build a real multiplayer game, live\n'
              '- Everything runs on Flutter and Supabase, no game servers',
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.title(
      title: 'Building a Real-Time Multiplayer Space Game',
      subtitle: 'with Flame and Supabase',
    );
  }
}
