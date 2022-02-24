import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slide_puzzle/bloc/puzzle_bloc.dart';

class TopSection extends StatelessWidget {
  const TopSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moves = context.select((PuzzleBloc bloc) => bloc.state.numberOfMoves);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: Text(
            context.read<PuzzleBloc>().state.puzzle.getDifficulty().name,
            style: const TextStyle(
              fontSize: 32,
              fontFamily: 'ThinkBig',
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12
          ),
          child: const Text(
            'separate everyone with the 1.5m blocks',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'HandWriting',
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // TODO: Add correct tiles number
              // const Text(
              //   '8 tiles',
              //   style: TextStyle(
              //     fontSize: 24,
              //     fontFamily: 'HandWriting',
              //   ),
              // ),
              // Container(
              //   width: 1,
              //   height: 13,
              //   color: Colors.black,
              //   margin: const EdgeInsets.symmetric(horizontal: 12),
              // ),
              Text(
                '$moves steps',
                style: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'HandWriting',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
