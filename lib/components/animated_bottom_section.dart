import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_me_alone/bloc/puzzle_bloc.dart';
import 'package:leave_me_alone/components/animated_elevated_button.dart';
import 'package:leave_me_alone/components/popup_hints.dart';
import 'package:leave_me_alone/helpers/modal_helper.dart';

class AnimatedBottomSection extends StatelessWidget {
  const AnimatedBottomSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final puzzle = context.select((PuzzleBloc bloc) => bloc.state.puzzle);
    final status = context.select((PuzzleBloc bloc) => bloc.state.status);
    final stage = context.select((PuzzleBloc bloc) => bloc.state.stage);

    final initDelay = 500 + puzzle.getDimension() * 250;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 64),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            visible: puzzle.hasNextDifficulty(),
            child: Container(
              margin: const EdgeInsets.only(right: 36),
              child: AnimatedElevatedButton(
                key: ValueKey(status),
                width: puzzle.hasNextDifficulty() && status == PuzzleStatus.complete
                  ? 80
                  : 136,
                height: 40,
                text:
                    puzzle.hasNextDifficulty() && status == PuzzleStatus.complete
                        ? 'Next Level'
                        : 'Shuffle',
                fontSize: 24,
                offset: 8,
                initDelay: Duration(
                  milliseconds: stage == PuzzleStage.initialized
                      ? initDelay +
                          puzzle.getDifficulty().name.length * 50 +
                          500 +
                          800
                      : 0,
                ),
                onPressed: () {
                  if (puzzle.hasNextDifficulty() &&
                      status == PuzzleStatus.complete) {
                    context.read<PuzzleBloc>().add(PuzzleInitialized(
                        difficulty: puzzle.getNextDifficulty()));
                  } else {
                    context.read<PuzzleBloc>().add(PuzzleReset());
                  }
                },
              ),
            ),
          ),
          AnimatedElevatedButton(
            key: ValueKey(status),
            width: status == PuzzleStatus.complete ? 136 : 80,
            height: 40,
            text: status == PuzzleStatus.complete ? 'Play Again' : 'Hint',
            fontSize: 24,
            offset: 8,
            initDelay: Duration(
                milliseconds: stage == PuzzleStage.initialized
                    ? initDelay +
                        puzzle.getDifficulty().name.length * 50 +
                        500 +
                        800
                    : 0),
            onPressed: () {
              if (status == PuzzleStatus.complete) {
                context.read<PuzzleBloc>().add(PuzzleReset());
              } else {
                showSlideDialog(
                  context: context,
                  child: const HintsPopup(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}