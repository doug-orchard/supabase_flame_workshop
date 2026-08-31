import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class CodePane extends StatelessWidget {
  const CodePane({
    required this.code,
    this.fileName,
    this.highlightedLines = const [],
    super.key,
  });

  final String code;
  final String? fileName;
  final List<int> highlightedLines;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: FlutterDeckCodeHighlight(
            code: code,
            fileName: fileName,
            language: 'dart',
            highlightedLines: highlightedLines,
          ),
        ),
      ),
    );
  }
}
