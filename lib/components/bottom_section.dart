import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_me_alone/bloc/puzzle_bloc.dart';
import 'package:leave_me_alone/components/app_elevated_button.dart';
import 'package:leave_me_alone/components/popup_hints.dart';
import 'package:leave_me_alone/helpers/modal_helper.dart';
import 'package:leave_me_alone/models/puzzle.dart';

class BottomSection extends StatelessWidget {
  const BottomSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final puzzle = context.select((PuzzleBloc bloc) => bloc.state.puzzle);
    final status = context.select((PuzzleBloc bloc) => bloc.state.status);

    bool _hasNextLevel = puzzle.getDifficulty() != PuzzleDifficulty.values.last;

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 64
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              margin: EdgeInsets.only(
                right: !_hasNextLevel && status == PuzzleStatus.complete ? 0 : 36,
              ),
              child: AppElevatedButton(
                width: !_hasNextLevel && status == PuzzleStatus.complete ? 0 : 136,
                height: 40,
                title: _hasNextLevel && status == PuzzleStatus.complete
                    ? 'Next Level'
                    : 'Shuffle',
                onTap: () {
                  if (_hasNextLevel && status == PuzzleStatus.complete) {
                    context.read<PuzzleBloc>().add(
                        PuzzleInitialized(difficulty: puzzle.getNextDifficulty()));
                  } else {
                    context.read<PuzzleBloc>().add(PuzzleReset());
                  }
                },
              ),
            ),
            AppElevatedButton(
              width: status == PuzzleStatus.complete ? 136 : 80,
              height: 40,
              title: status == PuzzleStatus.complete ? 'Play Again' : 'Hint',
              onTap: () {
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
      ),
    );
  }
}
