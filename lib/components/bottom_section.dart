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

    bool _hasNext = status == PuzzleStatus.complete &&
        puzzle.getDifficulty() != PuzzleDifficulty.values.last;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedOpacity(
            opacity: _hasNext ? 1 : 0,
            duration: const Duration(milliseconds: 300),
            child: Visibility(
              visible: _hasNext,
              child: AppElevatedButton(
                width: 136,
                height: 40,
                title: 'Next Level',
                onTap: () {
                  context.read<PuzzleBloc>().add(PuzzleInitialized(
                      difficulty: puzzle.getNextDifficulty()));
                },
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: status == PuzzleStatus.incomplete ? 1 : 0,
            duration: const Duration(milliseconds: 300),
            child: Visibility(
              visible: status == PuzzleStatus.incomplete,
              child: AppElevatedButton(
                width: 136,
                height: 40,
                title: 'Shuffle',
                onTap: () {
                  context.read<PuzzleBloc>().add(PuzzleReset());
                },
              ),
            ),
          ),
          Container(
            width: 36 * MediaQuery.of(context).size.width / 375,
          ),
          AnimatedOpacity(
            opacity: _hasNext ? 1 : 0,
            duration: const Duration(milliseconds: 300),
            child: Visibility(
              visible: _hasNext,
              child: AppElevatedButton(
                width: 136,
                height: 40,
                title: 'Play Again',
                onTap: () {
                  context.read<PuzzleBloc>().add(PuzzleReset());
                },
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: status == PuzzleStatus.incomplete ? 1 : 0,
            duration: const Duration(milliseconds: 300),
            child: Visibility(
              visible: status == PuzzleStatus.incomplete,
              child: AppElevatedButton(
                width: 80,
                height: 40,
                title: 'Hint',
                onTap: () {
                  showSlideDialog(
                    context: context,
                    child: const HintsPopup(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
