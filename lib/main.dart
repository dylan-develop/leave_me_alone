import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_me_alone/bloc/puzzle_bloc.dart';
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
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

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
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PuzzleBloc>(
          create: (context) => PuzzleBloc()
            ..add(const PuzzleInitialized(difficulty: PuzzleDifficulty.alpha)),
        ),
      ],
      child: MaterialApp.router(
        title: 'Leave Me Alone',
        scrollBehavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        routeInformationParser: BeamerParser(),
        routerDelegate: routerDelegate,
        backButtonDispatcher: BeamerBackButtonDispatcher(delegate: routerDelegate),
      ),
    );
  }
}
