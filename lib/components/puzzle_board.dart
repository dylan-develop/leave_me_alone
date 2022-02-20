import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slide_puzzle/bloc/puzzle_bloc.dart';
import 'package:slide_puzzle/components/puzzle_tile.dart';

class PuzzleBoard extends StatelessWidget {
  const PuzzleBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final puzzle = context.select((PuzzleBloc bloc) => bloc.state.puzzle);
    
    return Column(
      children: [
        SizedBox.square(
          dimension: 500,
          child: Container(
            color: Colors.orange,
            child: Stack(
              children: [
                for (int i = 0; i < puzzle.tiles.length; i++)
                  PuzzleTile(tile: puzzle.tiles[i])
              ],
            ),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.read<PuzzleBloc>().add(PuzzleReset());
                },
                child: const Text('Shuffle'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
