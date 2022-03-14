import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_me_alone/bloc/puzzle/puzzle_bloc.dart';
import 'package:leave_me_alone/components/animated_character_block.dart';
import 'package:leave_me_alone/components/animated_distance_block.dart';
import 'package:leave_me_alone/models/tile.dart';

class AnimatedPuzzleTile extends StatelessWidget {
  final Duration initDelay;
  final Tile tile;
  final double dimension;
  final int puzzleDimension;
  final int imageIndex;
  final bool isHints;

  const AnimatedPuzzleTile({
    Key? key,
    this.initDelay = Duration.zero,
    required this.tile,
    required this.puzzleDimension,
    required this.dimension,
    this.imageIndex = 1,
    required this.isHints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final status = context.select((PuzzleBloc bloc) => bloc.state.status);

    return AnimatedAlign(
      duration: const Duration(milliseconds: 500),
      alignment: FractionalOffset(
        tile.currentPosition.x / (puzzleDimension - 1),
        tile.currentPosition.y / (puzzleDimension - 1),
      ),
      child: Visibility(
        visible: tile.type != TileType.whitespace,
        child: GestureDetector(
          onTap: () {
            if (!(isHints || status == PuzzleStatus.complete)) {
              context.read<PuzzleBloc>().add(TileTapped(tile));
            }
          },
          child: SizedBox.square(
            dimension: dimension,
            child: tile.type == TileType.character
                ? AnimatedCharacterBlock(
                    initDelay: initDelay + Duration(milliseconds: 500 + tile.value * 250),
                    imageIndex: imageIndex,
                  )
                : AnimatedDistanceBlock(
                  initDelay: initDelay,
                  isHints: isHints,
                ),
          ),
        ),
      ),
    );
  }
}
