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
              'v3 draft branches\n'
              '- Supabase v3 for Dart is being built typesafe from the '
              'ground up\n'
              '- Two open draft pull requests on supabase-flutter lay the '
              'groundwork: #1634 typed table access, #1635 supabase_typegen\n'
              '- The dependency_overrides in the workshop repository wire '
              'them in\n'
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
          'PR #1634: PostgrestTable, TableColumn, typed queries and streams',
          'PR #1635: supabase_typegen generates types from your schema',
          'Everything we build today runs on those draft branches',
        ],
      ),
    );
  }
}
