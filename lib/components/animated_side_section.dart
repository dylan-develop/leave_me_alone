import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_me_alone/bloc/puzzle_bloc.dart';
import 'package:leave_me_alone/components/animated_elevated_button.dart';
import 'package:leave_me_alone/components/animated_typer_text.dart';
import 'package:leave_me_alone/components/popup_hints.dart';
import 'package:leave_me_alone/helpers/modal_helper.dart';

import 'animated_moves_number.dart';

class AnimatedSideSection extends StatelessWidget {
  const AnimatedSideSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final puzzle = context.select((PuzzleBloc bloc) => bloc.state.puzzle);
    final status = context.select((PuzzleBloc bloc) => bloc.state.status);
    final stage = context.select((PuzzleBloc bloc) => bloc.state.stage);

    final initDelay = 500 + 500 + pow(puzzle.getDimension(), 2) ~/ 2 * 250;

    return Center(
      key: ValueKey(puzzle.getDifficulty()),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 24),
              child: AnimatedTyperText(
                text: puzzle.getDifficulty().name,
                fontSize: 96,
                fontFamily: 'ThinkBig',
                initDelay: Duration(
                  milliseconds: initDelay,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 40),
              child: AnimatedTyperText(
                text: 'separate everyone with the blocks to win',
                fontSize: 36,
                initDelay: Duration(
                  milliseconds: initDelay + puzzle.getDifficulty().name.length * 50,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            AnimatedMovesNumber(
              initDelay: Duration(
                milliseconds: initDelay + puzzle.getDifficulty().name.length * 50 + 2000,
              ),
              fontSize: 36,
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 48),
              child: AnimatedElevatedButton(
                key: ValueKey(status),
                initDelay: Duration(
                  milliseconds: stage == PuzzleStage.initialized
                    ? initDelay + puzzle.getDifficulty().name.length * 50 + 2000 + 500
                    : 0
                ),
                width: status == PuzzleStatus.incomplete ? 133 : 240,
                height: 56,
                text: status == PuzzleStatus.incomplete ? 'Hint' : 'Play Again',
                fontSize: 36,
                offset: 8,
                onPressed: () {
                  if (status == PuzzleStatus.incomplete) {
                    showSlideDialog(
                      context: context,
                      child: const HintsPopup(),
                    );
                  } else {
                    context.read<PuzzleBloc>().add(PuzzleReset());
                  }
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                bottom: 48,
              ),
              child: AnimatedElevatedButton(
                key: ValueKey(status),
                width: status == PuzzleStatus.complete ? puzzle.hasNextDifficulty() ? 240 : 0 : 296,
                height: 56,
                text: status == PuzzleStatus.complete && puzzle.hasNextDifficulty() ? 'Next level' : 'Shuffle',
                fontSize: 36,
                offset: 8,
                initDelay: Duration(
                  milliseconds: stage == PuzzleStage.initialized
                    ? initDelay + puzzle.getDifficulty().name.length * 50 + 2000 + 500
                    : 0
                ),
                onPressed: () {
                  if (status == PuzzleStatus.complete && puzzle.hasNextDifficulty()) {
                    context.read<PuzzleBloc>().add(PuzzleInitialized(difficulty: puzzle.getNextDifficulty()));
                  } else {
                    context.read<PuzzleBloc>().add(PuzzleReset());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
