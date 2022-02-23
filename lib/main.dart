import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slide_puzzle/bloc/puzzle_bloc.dart';
import 'package:slide_puzzle/screens/difficulties.dart';
import 'package:slide_puzzle/screens/game.dart';
import 'package:slide_puzzle/screens/onboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PuzzleBloc>(
          create: (context) => PuzzleBloc()
            ..add(const PuzzleInitialized(
              dimension: 4,
            )),
        ),
      ],
      child: MaterialApp(
        title: 'Slide Puzzle',
        initialRoute: '/',
        routes: {
          '/': (context) => const OnboardPage(),
          '/difficulties': (context) => const DifficultiesPage(),
          '/game': (context) => const GamePage(),
        },
      ),
    );
  }
}
