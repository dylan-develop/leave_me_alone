import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slide_puzzle/bloc/puzzle_bloc.dart';
import 'package:slide_puzzle/components/elevated_button.dart';
import 'package:slide_puzzle/components/popup_hints.dart';
import 'package:slide_puzzle/helpers/modal_helper.dart';
import 'package:slide_puzzle/models/puzzle.dart';

class BottomSection extends StatelessWidget {
  const BottomSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final puzzle = context.select((PuzzleBloc bloc) => bloc.state.puzzle);
    final status = context.select((PuzzleBloc bloc) => bloc.state.status);

    bool _hasNext = status == PuzzleStatus.complete &&
        puzzle.getDifficulty() != PuzzleDifficulty.values.last;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomElevatedButton(
            title: _hasNext ? 'Next level' : 'Shuffle',
            onPressed: () {
              if (_hasNext) {
                context.read<PuzzleBloc>().add(PuzzleInitialized(
                    difficulty: PuzzleDifficulty.values[PuzzleDifficulty.values
                        .indexOf(puzzle.getDifficulty())]));
              } else {
                context.read<PuzzleBloc>().add(PuzzleReset());
              }
            },
          ),
          CustomElevatedButton(
            title: _hasNext ? 'Again' : 'Hint',
            onPressed: () {
              if (_hasNext) {
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
