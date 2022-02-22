import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slide_puzzle/bloc/puzzle_bloc.dart';
import 'package:slide_puzzle/components/puzzle_tile.dart';
import 'package:slide_puzzle/models/puzzle.dart';

class PuzzleBoard extends StatelessWidget {
  final double dimenision;
  final bool isHints;

  const PuzzleBoard({
    Key? key,
    required this.dimenision,
    this.isHints = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Puzzle puzzle = context.select((PuzzleBloc bloc) => bloc.state.puzzle);
    PuzzleStatus status = context.select((PuzzleBloc bloc) => bloc.state.status);

    if (isHints) {
      puzzle = puzzle.sort();
    }

    return SizedBox.square(
      dimension: dimenision,
      child: Stack(
        children: [
          for (int i = 0; i < puzzle.tiles.length; i++)
            PuzzleTile(
              tile: puzzle.tiles[i],
              puzzleDimension: puzzle.getDimension(),
              dimension: dimenision / puzzle.getDimension(),
              isReadOnly: status == PuzzleStatus.complete,
              isHints: isHints,
            ),
        ],
      ),
    );
  }
}
