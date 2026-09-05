import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:google_fonts/google_fonts.dart';

FlutterDeckThemeData buildDeckTheme() {
  final base = FlutterDeckThemeData.dark();
  final textTheme = base.textTheme.merge(
    FlutterDeckTextTheme(
      display: GoogleFonts.spaceGrotesk(
        fontSize: 96,
        fontWeight: FontWeight.w700,
        height: 1.1,
      ),
      header: GoogleFonts.spaceGrotesk(
        fontSize: 57,
        fontWeight: FontWeight.w600,
        height: 1.15,
      ),
      title: GoogleFonts.spaceGrotesk(
        fontSize: 54,
        fontWeight: FontWeight.w600,
        height: 1.15,
      ),
      subtitle: GoogleFonts.inter(fontSize: 38, height: 1.3),
      bodyLarge: GoogleFonts.inter(fontSize: 28, height: 1.4),
      bodyMedium: GoogleFonts.inter(fontSize: 22, height: 1.4),
      bodySmall: GoogleFonts.inter(fontSize: 16, height: 1.4),
    ),
  );
  return FlutterDeckThemeData.fromThemeAndText(
    base.materialTheme,
    textTheme,
  ).copyWith(
    bulletListTheme: FlutterDeckBulletListThemeData(
      textStyle: GoogleFonts.inter(
        fontSize: 38,
        fontWeight: FontWeight.w500,
        height: 1.35,
      ),
    ),
    codeHighlightTheme: FlutterDeckCodeHighlightThemeData(
      backgroundColor: const Color(0xFF14141D),
      textStyle: GoogleFonts.jetBrainsMono(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        height: 1.55,
      ),
    ),
  );
}

const deckAccent = Color(0xFF3ECF8E);
