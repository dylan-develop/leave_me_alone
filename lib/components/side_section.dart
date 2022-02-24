import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_me_alone/bloc/puzzle_bloc.dart';
import 'package:leave_me_alone/components/elevated_button.dart';
import 'package:leave_me_alone/components/popup_hints.dart';
import 'package:leave_me_alone/helpers/modal_helper.dart';
import 'package:leave_me_alone/models/puzzle.dart';

class SideSection extends StatelessWidget {
  const SideSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final puzzle = context.select((PuzzleBloc bloc) => bloc.state.puzzle);
    final status = context.select((PuzzleBloc bloc) => bloc.state.status);
    final moves = context.select((PuzzleBloc bloc) => bloc.state.numberOfMoves);

    bool _hasNext = status == PuzzleStatus.complete &&
        puzzle.getDifficulty() != PuzzleDifficulty.values.last;

    return Container(
      margin: const EdgeInsets.all(12),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 24),
              child: Text(
                context.read<PuzzleBloc>().state.puzzle.getDifficulty().name,
                style: const TextStyle(
                  fontSize: 96,
                  fontFamily: 'ThinkBig',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 40),
              child: const Text(
                'separate everyone with the blocks to win',
                style: TextStyle(
                  fontSize: 36,
                  fontFamily: 'HandWriting',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 40),
              child: Wrap(
                children: [
                  // TODO: Add correct tiles number
                  /*
                  const Text(
                    '8 tiles',
                    style: TextStyle(
                      fontSize: 36,
                      fontFamily: 'HandWriting',
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.black,
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                  ),
                  */
                  Text(
                    '$moves steps',
                    style: const TextStyle(
                      fontSize: 36,
                      fontFamily: 'HandWriting',
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(
                bottom: 48,
              ),
              child: CustomElevatedButton(
                title: _hasNext ? 'Again' : 'Hint',
                fontSize: 36,
                padding: const EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 52,
                ),
                onPressed: () {
                  if (_hasNext) {
                    context.read<PuzzleBloc>().add(PuzzleReset());
                  } else {
                    showSlideDialog(
                      context: context,
                      child: const HintsPopup(),
                      beginOffset: const Offset(-1, 0),
                    );
                  }
                },
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  alignment: Alignment.centerLeft,
                  child: CustomElevatedButton(
                    title: _hasNext ? 'Next level' : 'Shuffle',
                    fontSize: 36,
                    padding: EdgeInsets.symmetric(
                      vertical: 3,
                      horizontal: constraints.maxWidth * 0.6 / 2,
                    ),
                    onPressed: () {
                      if (_hasNext) {
                        context.read<PuzzleBloc>().add(PuzzleInitialized(
                            difficulty: PuzzleDifficulty.values[PuzzleDifficulty
                                .values
                                .indexOf(puzzle.getDifficulty())]));
                      } else {
                        context.read<PuzzleBloc>().add(PuzzleReset());
                      }
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
