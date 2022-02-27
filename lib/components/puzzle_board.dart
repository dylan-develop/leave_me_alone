import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_me_alone/bloc/puzzle_bloc.dart';
import 'package:leave_me_alone/components/puzzle_tile.dart';
import 'package:leave_me_alone/models/puzzle.dart';

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
    PuzzleStatus status =
        context.select((PuzzleBloc bloc) => bloc.state.status);

    if (isHints) {
      puzzle = puzzle.sort();
    }

    return GestureDetector(
      onHorizontalDragEnd: (details) {
        final puzzle = context.read<PuzzleBloc>().state.puzzle;

        if (details.primaryVelocity! > 0) {
          final tile =
              puzzle.getTileRelativeToWhitespaceTile(const Offset(-1, 0));
          if (tile != null) {
            context.read<PuzzleBloc>().add(TileTapped(tile));
          }
        }

        if (details.primaryVelocity! < 0) {
          final tile =
              puzzle.getTileRelativeToWhitespaceTile(const Offset(1, 0));
          if (tile != null) {
            context.read<PuzzleBloc>().add(TileTapped(tile));
          }
        }
      },
      onVerticalDragEnd: (details) {
        final puzzle = context.read<PuzzleBloc>().state.puzzle;

        if (details.primaryVelocity! > 0) {
          final tile =
              puzzle.getTileRelativeToWhitespaceTile(const Offset(0, -1));
          if (tile != null) {
            context.read<PuzzleBloc>().add(TileTapped(tile));
          }
        }
        // Swiping in down direction.
        if (details.primaryVelocity! < 0) {
          final tile =
              puzzle.getTileRelativeToWhitespaceTile(const Offset(0, 1));
          if (tile != null) {
            context.read<PuzzleBloc>().add(TileTapped(tile));
          }
        }
      },
      child: SizedBox.square(
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
      ),
    );
  }
}
