import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';

import '../widgets/side_bullets.dart';

class TypedV3Slide extends FlutterDeckSlideWidget {
  const TypedV3Slide()
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/typed-v3',
          title: 'Toward a typesafe Supabase v3',
          steps: 4,
          speakerNotes:
              '- Say this up front: everything we build today runs on the '
              'v3 prerelease\n'
              '- Supabase v3 for Dart is being built typesafe from the '
              'ground up\n'
              '- Both pull requests landed: #1634 typed table access, '
              '#1635 supabase_typegen\n'
              '- Fresh off the press, so you get to use it before the '
              'stable release\n'
              '- Typed Broadcast and Presence are the next step',
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => const SideBullets(
        useSteps: true,
        items: [
          'Supabase v3 for Dart is typesafe from the ground up',
          '#1634 merged: PostgrestTable, TableColumn, typed queries and '
              'streams',
          '#1635 merged: supabase_typegen generates types from your schema',
          'Both on pub.dev today, in the 3.0.0-dev.2 prerelease',
        ],
      ),
    );
  }
}
