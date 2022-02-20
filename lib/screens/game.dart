import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slide_puzzle/bloc/puzzle_bloc.dart';
import 'package:slide_puzzle/components/bottom_section.dart';
import 'package:slide_puzzle/components/puzzle_board.dart';
import 'package:slide_puzzle/components/responsive_layout_builder.dart';
import 'package:slide_puzzle/components/top_section.dart';

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PuzzleBloc>(
          create: (context) => PuzzleBloc()..add(PuzzleReset()),
        ),
      ],
      child: Scaffold(
        body: ResponsiveLayoutBuilder(
          mobile: Column(
            children: [
              const Expanded(
                flex: 6,
                child: TopSection(),
              ),
              Expanded(
                flex: 9,
                child: PuzzleBoard(
                  dimenision: min(
                    MediaQuery.of(context).size.width - 16 * 2,
                    MediaQuery.of(context).size.height * 9 / 20,
                  ),
                ),
              ),
              const Expanded(
                flex: 5,
                child: BottomSection(),
              ),
            ],
          ),
          desktop: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.pink,
                ),
              ),
              Expanded(
                flex: 3,
                child: Center(
                  child: PuzzleBoard(
                    dimenision: min(
                      MediaQuery.of(context).size.width * 3 / 5,
                      MediaQuery.of(context).size.height - 167 * 2
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
