# Skeleton

The starting point for the workshop exercises. Everything that is plumbing
rather than learning is already in place, so you can spend the workshop on
Flame and Supabase Realtime instead of on `pubspec.yaml`.

## What you get

| Path | What it is |
| --- | --- |
| `pubspec.yaml` | `flame`, `supabase_flutter` 3.0.0-dev.2, and `supabase_typegen`, all from pub.dev |
| `lib/main.dart` | The entry point, with the exercise 1 gap marked |
| `lib/src/env.dart` | `SUPABASE_URL`, `SUPABASE_KEY`, and `ROOM` dart-defines, defaulted to the local stack |
| `lib/src/game_config.dart` | Every tuning constant the exercises refer to |
| `lib/src/app/` | A placeholder shell that reports whether you have a session |
| `web/` | Web scaffolding, so `flutter run -d chrome` works out of the box |

Nothing else. The game itself is what you build.

## Run it

From the repository root, once:

```sh
dart pub get
```

Then:

```sh
cd packages/skeleton
flutter run -d chrome
```

Against a hosted project instead of the local stack:

```sh
flutter run -d chrome \
  --dart-define=SUPABASE_URL=https://your-ref.supabase.co \
  --dart-define=SUPABASE_KEY=sb_publishable_... \
  --dart-define=ROOM=main
```

The launch pad screen turns green once exercise 1 is done.

## Reference

`packages/game` is the finished version. Reach for it when you fall behind,
but write the code yourself first.
