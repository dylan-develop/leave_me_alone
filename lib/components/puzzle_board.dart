import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slide_puzzle/bloc/puzzle_bloc.dart';
import 'package:slide_puzzle/components/puzzle_tile.dart';
import 'package:slide_puzzle/models/puzzle.dart';

class PuzzleBoard extends StatelessWidget {
  final double dimenision;
  final bool isReadOnly;

  const PuzzleBoard({
    Key? key,
    required this.dimenision,
    this.isReadOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Puzzle puzzle = context.select((PuzzleBloc bloc) => bloc.state.puzzle);

    if (isReadOnly) {
      puzzle = puzzle.sort();
    }

    return SizedBox.square(
      dimension: dimenision,
      child: Stack(
        children: [
          for (int i = 0; i < puzzle.tiles.length; i++)
            PuzzleTile(
              tile: puzzle.tiles[i],
              dimension: dimenision / 3,
              isReadOnly: isReadOnly,
            ),
        ],
      ),
    );
  }
}
