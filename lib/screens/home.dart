import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slide_puzzle/bloc/puzzle_bloc.dart';
import 'package:slide_puzzle/components/puzzle_board.dart';
import 'package:slide_puzzle/components/simple_puzzle_board.dart';

import '../components/animated_puzzle_board.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PuzzleBloc>(
          create: (context) => PuzzleBloc()..add(PuzzleReset()),
        ),
      ],
      child: const Scaffold(
        body: Center(
          child: PuzzleBoard(),
        )
      ),
    );
  }
}
