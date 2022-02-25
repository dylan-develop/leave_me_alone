import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_me_alone/bloc/puzzle_bloc.dart';
import 'package:leave_me_alone/components/app_elevated_button.dart';
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

    bool _hasNextLevel = puzzle.getDifficulty() != PuzzleDifficulty.values.last;

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
              height: 36,
              margin: const EdgeInsets.only(bottom: 40),
              child: Wrap(
                children: [
                  AnimatedOpacity(
                    opacity: status == PuzzleStatus.complete ? 1 : 0,
                    duration: const Duration(milliseconds: 500),
                    child: Container(
                      margin: const EdgeInsets.only(right: 24),
                      child: Visibility(
                        visible: status == PuzzleStatus.complete,
                        child: Image.asset(
                          'assets/images/mask.png',
                          width: 68,
                          height: 32,
                        ),
                      ),
                    ),
                  ),
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
              margin: const EdgeInsets.only(
                bottom: 48,
              ),
              child: AppElevatedButton(
                width: status == PuzzleStatus.incomplete ? 133 : 200,
                height: 56,
                title: status == PuzzleStatus.incomplete ? 'Hint' : 'Play Again',
                fontSize: 36,
                onTap: () {
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
              child: AppElevatedButton(
                width: status == PuzzleStatus.complete ? _hasNextLevel ? 200 : 0 : 296,
                height: 56,
                title: status == PuzzleStatus.complete && _hasNextLevel ? 'Next level' : 'Shuffle',
                fontSize: 36,
                onTap: () {
                  if (status == PuzzleStatus.complete && _hasNextLevel) {
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
