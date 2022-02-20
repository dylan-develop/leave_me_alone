import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slide_puzzle/bloc/puzzle_bloc.dart';
import 'package:slide_puzzle/components/puzzle_tile.dart';

class PuzzleBoard extends StatelessWidget {
  final double dimenision;

  const PuzzleBoard({
    Key? key,
    required this.dimenision,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final puzzle = context.select((PuzzleBloc bloc) => bloc.state.puzzle);

    return SizedBox.square(
      dimension: dimenision,
      child: Stack(
        children: [
          for (int i = 0; i < puzzle.tiles.length; i++)
            PuzzleTile(
              tile: puzzle.tiles[i],
              dimension: dimenision / 3,
            ),
        ],
      ),
    );
  }
}
