import 'package:flutter/widgets.dart';

import 'src/app/game_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Exercise 1: initialize Supabase with Env.supabaseUrl and Env.supabaseKey,
  // then sign in anonymously when there is no session yet.

  runApp(const GameApp());
}
