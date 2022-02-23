import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slide_puzzle/bloc/puzzle_bloc.dart';
import 'package:slide_puzzle/components/elevated_button.dart';
import 'package:slide_puzzle/components/popup_hints.dart';
import 'package:slide_puzzle/helpers/modal_helper.dart';

class SideSection extends StatelessWidget {
  const SideSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moves = context.select((PuzzleBloc bloc) => bloc.state.numberOfMoves);

    return Container(
      margin: const EdgeInsets.all(12),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 24),
              child: Text(
                context.read<PuzzleBloc>().state.puzzle.getDifficulty().name,
                style: const TextStyle(
                  fontSize: 96,
                  fontFamily: 'ThinkBig',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 40),
              child: const Text(
                'separate everyone with the 1.5m blocks',
                style: TextStyle(
                  fontSize: 36,
                  fontFamily: 'HandWriting',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 40),
              child: Wrap(
                children: [
                  // TODO: Add correct tiles number
                  // const Text(
                  //   '8 tiles',
                  //   style: TextStyle(
                  //     fontSize: 36,
                  //     fontFamily: 'HandWriting',
                  //   ),
                  // ),
                  // Container(
                  //   width: 1,
                  //   height: 40,
                  //   color: Colors.black,
                  //   margin: const EdgeInsets.symmetric(horizontal: 32),
                  // ),
                  Text(
                    '$moves steps',
                    style: const TextStyle(
                      fontSize: 36,
                      fontFamily: 'HandWriting',
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 40),
              child: CustomElevatedButton(
                key: UniqueKey(),
                title: 'Shuffle',
                fontSize: 36,
                onPressed: () {
                  context.read<PuzzleBloc>().add(PuzzleReset());
                },
              ),
            ),
            CustomElevatedButton(
              title: 'Hint',
              fontSize: 36,
              onPressed: () {
                showSlideDialog(
                  context: context,
                  child: const HintsPopup(),
                  beginOffset: const Offset(-1 , 0),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
