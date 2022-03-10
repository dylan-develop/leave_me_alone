import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_me_alone/bloc/puzzle_bloc.dart';
import 'package:leave_me_alone/components/animated_character_block.dart';
import 'package:leave_me_alone/components/animated_distance_block.dart';
import 'package:leave_me_alone/models/tile.dart';

class AnimatedPuzzleTile extends StatelessWidget {
  final Duration initDelay;
  final int puzzleDimension;
  final double dimension;
  final Tile tile;

  const AnimatedPuzzleTile({
    Key? key,
    this.initDelay = Duration.zero,
    required this.tile,
    required this.puzzleDimension,
    required this.dimension,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            context.read<PuzzleBloc>().add(TileTapped(tile));
          },
          child: SizedBox.square(
            dimension: dimension,
            child: tile.type == TileType.character
                ? AnimatedCharacterBlock(
                    initDelay: Duration(milliseconds: 500 + tile.value * 250),
                    imageUrl: 'assets/images/character0.png',
                  )
                : const AnimatedDistanceBlock(),
          ),
        ),
      ),
    );
  }
}
