import 'package:flutter/material.dart';

import 'launch_pad.dart';

class GameApp extends StatelessWidget {
  const GameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nebula Standoff',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: const Scaffold(
        backgroundColor: Color(0xFF07070F),
        // Exercise 2: swap this for a GameWidget<SpaceGame>.
        body: LaunchPad(),
      ),
    );
  }
}
