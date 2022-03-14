import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_me_alone/bloc/audio_control/audio_control_bloc.dart';
import 'package:leave_me_alone/bloc/puzzle/puzzle_bloc.dart';
import 'package:leave_me_alone/helpers/cache_helper.dart';
import 'package:leave_me_alone/models/puzzle.dart';
import 'package:leave_me_alone/screens/difficulties.dart';
import 'package:leave_me_alone/screens/game.dart';
import 'package:leave_me_alone/screens/onboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final routerDelegate = BeamerDelegate(
    locationBuilder: RoutesLocationBuilder(
      routes: {
        '/': (context, state, data) => const BeamPage(
              key: ValueKey('onboard'),
              title: 'Welcome',
              child: OnboardPage(),
              type: BeamPageType.fadeTransition,
            ),
        '/difficulties': (context, state, data) => const BeamPage(
              key: ValueKey('difficulties'),
              title: 'Difficulties',
              child: DifficultiesPage(),
              type: BeamPageType.fadeTransition,
            ),
        '/puzzle': (context, state, data) => const BeamPage(
              key: ValueKey('puzzle'),
              title: 'Puzzle',
              child: GamePage(),
              type: BeamPageType.fadeTransition,
            ),
      },
    ),
  );

  @override
  void initState() {
    prefetchToMemory([
      'assets/audio/female_cough.wav',
      'assets/audio/male_cough.wav',
      'assets/audio/sneeze.wav',
      'assets/lottie/char_1.json',
      'assets/lottie/char_2.json',
      'assets/lottie/char_3.json',
      'assets/lottie/char_4.json',
      'assets/lottie/char_5.json',
      'assets/lottie/char_6.json',
      'assets/lottie/char_7.json',
      'assets/lottie/char_8.json',
      'assets/lottie/char_9.json',
      'assets/lottie/char_10.json',
      'assets/lottie/char_11.json',
      'assets/lottie/char_12.json',
    ]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PuzzleBloc>(
          create: (context) => PuzzleBloc()
            ..add(const PuzzleInitialized(difficulty: PuzzleDifficulty.alpha)),
        ),
        BlocProvider<AudioControlBloc>(
          create: (context) => AudioControlBloc(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Leave Me Alone',
        scrollBehavior:
            ScrollConfiguration.of(context).copyWith(scrollbars: false),
        routeInformationParser: BeamerParser(),
        routerDelegate: routerDelegate,
        backButtonDispatcher:
            BeamerBackButtonDispatcher(delegate: routerDelegate),
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
      ),
    );
  }
}
