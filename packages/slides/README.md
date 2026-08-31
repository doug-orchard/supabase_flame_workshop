# Workshop slides

The deck for "Building a Real-Time Multiplayer Space Game with Flame and
Supabase", built with [flutter_deck](https://pub.dev/packages/flutter_deck).

```sh
flutter run -d chrome
```

Arrow keys navigate, the period key toggles the navigation drawer, and the
presenter view (with speaker notes) opens from the deck controls.

## Keeping code snippets in sync

Slide code snippets are string constants inside each slide file. Every
`CodePane` labels its snippet with the true source path in the game package
(for example `packages/game/lib/src/game/components/remote_ship.dart`). When
game code changes, search the slides for that path and update the snippet to
match the source.
