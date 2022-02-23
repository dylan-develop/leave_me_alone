import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slide_puzzle/bloc/puzzle_bloc.dart';

class TopSection extends StatelessWidget {
  const TopSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moves = context.select((PuzzleBloc bloc) => bloc.state.numberOfMoves);
    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            'BETA',
            style: TextStyle(
              fontSize: 32,
              fontFamily: 'ThinkBig',
            ),
          ),
          const Text(
            'separate everyone with the 1.5m blocks',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'HandWriting',
            ),
            textAlign: TextAlign.center,
          ),
          Row(
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
                  fontSize: 24,
                  fontFamily: 'HandWriting',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
