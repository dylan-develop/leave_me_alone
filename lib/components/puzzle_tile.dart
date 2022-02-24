import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_me_alone/bloc/puzzle_bloc.dart';
import 'package:leave_me_alone/components/character_block.dart';
import 'package:leave_me_alone/components/social_distance_block.dart';
import 'package:leave_me_alone/models/tile.dart';

class PuzzleTile extends StatelessWidget {
  final Tile tile;
  final double dimension;
  final bool isReadOnly;
  final bool isHints;
  final int puzzleDimension;

  const PuzzleTile({
    Key? key,
    required this.tile,
    required this.dimension,
    this.isReadOnly = false,
    this.isHints = false,
    required this.puzzleDimension,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: tile.type != TileType.whitespace,
      child: AnimatedAlign(
        duration: const Duration(milliseconds: 500),
        alignment: FractionalOffset(
          tile.currentPosition.x / (puzzleDimension - 1),
          tile.currentPosition.y / (puzzleDimension - 1),
        ),
        child: GestureDetector(
          onTap: () {
            if (!isReadOnly || !isHints) {
              context.read<PuzzleBloc>().add(TileTapped(tile));
            }
          },
          child: SizedBox.square(
            dimension: dimension,
            child: tile.type == TileType.character
                ? CharacterBlock(isHints: isHints)
                : SocialDistanceBlock(isHints: isHints),
          ),
        ),
      ),
    );
  }
}
