import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slide_puzzle/bloc/puzzle_bloc.dart';
import 'package:slide_puzzle/models/tile.dart';

class PuzzleTile extends StatelessWidget {
  final Tile tile;
  final double dimension;

  const PuzzleTile({
    Key? key,
    required this.tile,
    required this.dimension,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !tile.isWhitespace,
      child: AnimatedAlign(
        duration: const Duration(seconds: 1),
        alignment: FractionalOffset(
          tile.currentPosition.x / (3 - 1),
          tile.currentPosition.y / (3 - 1),
        ),
        child: GestureDetector(
          onTap: () {
            context.read<PuzzleBloc>().add(TileTapped(tile));
          },
          child: SizedBox.square(
            dimension: dimension,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
                color: tile.value % 2 == 0 ? Colors.red : Colors.blue,
              ),
              child: Center(
                child: Text(
                  tile.value % 2 == 0
                      ? 'Character #${tile.value}'
                      : 'Social Distance #${tile.value}',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
