import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_me_alone/bloc/puzzle_bloc.dart';
import 'package:leave_me_alone/components/animated_moves_number.dart';
import 'package:leave_me_alone/components/animated_typer_text.dart';

class AnimatedTopSection extends StatelessWidget {
  const AnimatedTopSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final puzzle = context.select((PuzzleBloc bloc) => bloc.state.puzzle);

    final initDelay = 500 + puzzle.getDimension() * 250;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          child: AnimatedTyperText(
            text: puzzle.getDifficulty().name,
            fontSize: 32,
            fontFamily: 'ThinkBig',
            initDelay: Duration(
              milliseconds: initDelay,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: AnimatedTyperText(
            text: 'separate everyone with the blocks to win',
            fontSize: 20,
            initDelay: Duration(
              milliseconds: initDelay + puzzle.getDifficulty().name.length * 50,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          height: 32,
          child: Center(
            child: AnimatedMovesNumber(
              initDelay: Duration(
                milliseconds: initDelay +
                    puzzle.getDifficulty().name.length * 50 +
                    500 +
                    800,
              ),
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }
}
