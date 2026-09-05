import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_deck_web_client/flutter_deck_web_client.dart';

import 'deck_theme.dart';
import 'slides/s01_title.dart';
import 'slides/s02_speakers.dart';
import 'slides/s03_agenda.dart';
import 'slides/s04_why_serverless.dart';
import 'slides/s05_architecture.dart';
import 'slides/s06_credits.dart';
import 'slides/s07_typed_v3.dart';
import 'slides/s08_v2_vs_v3.dart';
import 'slides/s09_setup.dart';
import 'slides/s10_github_sync.dart';
import 'slides/s11_skeleton.dart';
import 'slides/s12_run_the_game.dart';
import 'slides/s13_exercise_liftoff.dart';
import 'slides/s14_flame_intro.dart';
import 'slides/s15_components.dart';
import 'slides/s16_game_loop.dart';
import 'slides/s17_ship.dart';
import 'slides/s18_input.dart';
import 'slides/s19_camera.dart';
import 'slides/s20_exercise_fly.dart';
import 'slides/s21_shared_seed.dart';
import 'slides/s22_asteroids.dart';
import 'slides/s23_exercise_asteroids.dart';
import 'slides/s24_realtime.dart';
import 'slides/s25_connect.dart';
import 'slides/s26_events.dart';
import 'slides/s27_exercise_connect.dart';
import 'slides/s28_state_sync.dart';
import 'slides/s29_dead_reckoning.dart';
import 'slides/s30_exercise_sync.dart';
import 'slides/s31_presence.dart';
import 'slides/s32_phases.dart';
import 'slides/s33_round_start.dart';
import 'slides/s34_exercise_lobby.dart';
import 'slides/s35_shooting.dart';
import 'slides/s36_victim_auth.dart';
import 'slides/s37_death.dart';
import 'slides/s38_win.dart';
import 'slides/s39_exercise_combat.dart';
import 'slides/s40_zone.dart';
import 'slides/s41_disconnects.dart';
import 'slides/s42_exercise_storm.dart';
import 'slides/s43_typed_tables.dart';
import 'slides/s44_typed_stream.dart';
import 'slides/s45_exercise_leaderboard.dart';
import 'slides/s46_demo.dart';
import 'slides/s47_deploy.dart';
import 'slides/s48_stretch.dart';
import 'slides/s49_thanks.dart';

void main() => runApp(const WorkshopSlides());

class WorkshopSlides extends StatelessWidget {
  const WorkshopSlides({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterDeckApp(
      client: FlutterDeckWebClient(),
      configuration: FlutterDeckConfiguration(
        footer: const FlutterDeckFooterConfiguration(
          showSlideNumbers: true,
          showSocialHandle: true,
        ),
        header: const FlutterDeckHeaderConfiguration(showHeader: false),
        slideSize: FlutterDeckSlideSize.fromAspectRatio(
          aspectRatio: const FlutterDeckAspectRatio.ratio16x9(),
          resolution: const FlutterDeckResolution.fhd(),
        ),
        transition: const FlutterDeckTransition.fade(),
      ),
      lightTheme: buildDeckTheme(),
      darkTheme: buildDeckTheme(),
      themeMode: ThemeMode.dark,
      slides: const [
        TitleSlide(),
        SpeakersSlide(),
        AgendaSlide(),
        WhyServerlessSlide(),
        ArchitectureSlide(),
        CreditsSlide(),
        TypedV3Slide(),
        V2VersusV3Slide(),
        SetupSlide(),
        GithubSyncSlide(),
        SkeletonSlide(),
        RunTheGameSlide(),
        ExerciseLiftoffSlide(),
        FlameIntroSlide(),
        ComponentsSlide(),
        GameLoopSlide(),
        ShipSlide(),
        InputSlide(),
        CameraSlide(),
        ExerciseFlySlide(),
        SharedSeedSlide(),
        AsteroidsSlide(),
        ExerciseAsteroidsSlide(),
        RealtimeSlide(),
        ConnectSlide(),
        EventsSlide(),
        ExerciseConnectSlide(),
        StateSyncSlide(),
        DeadReckoningSlide(),
        ExerciseSyncSlide(),
        PresenceSlide(),
        PhasesSlide(),
        RoundStartSlide(),
        ExerciseLobbySlide(),
        ShootingSlide(),
        VictimAuthSlide(),
        DeathSlide(),
        WinSlide(),
        ExerciseCombatSlide(),
        ZoneSlide(),
        DisconnectsSlide(),
        ExerciseStormSlide(),
        TypedTablesSlide(),
        TypedStreamSlide(),
        ExerciseLeaderboardSlide(),
        DemoSlide(),
        DeploySlide(),
        StretchSlide(),
        ThanksSlide(),
      ],
    );
  }
}
