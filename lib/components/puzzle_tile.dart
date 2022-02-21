import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slide_puzzle/bloc/puzzle_bloc.dart';
import 'package:slide_puzzle/components/character_block.dart';
import 'package:slide_puzzle/components/social_distance_block.dart';
import 'package:slide_puzzle/models/tile.dart';

class PuzzleTile extends StatelessWidget {
  final Tile tile;
  final double dimension;
  final bool isReadOnly;

  const PuzzleTile({
    Key? key,
    required this.tile,
    required this.dimension,
    this.isReadOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !tile.isWhitespace,
      child: AnimatedAlign(
        duration: const Duration(milliseconds: 500),
        alignment: FractionalOffset(
          tile.currentPosition.x / (3 - 1),
          tile.currentPosition.y / (3 - 1),
        ),
        child: GestureDetector(
          onTap: () {
            if (!isReadOnly) {
              context.read<PuzzleBloc>().add(TileTapped(tile));
            }
          },
          child: SizedBox.square(
            dimension: dimension,
            child: tile.value % 2 == 0
                ? const CharacterBlock()
                : SocialDistanceBlock(fontSize: isReadOnly ? 24 : null),
          ),
        ),
      ),
    );
  }
}
