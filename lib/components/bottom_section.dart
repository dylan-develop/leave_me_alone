import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slide_puzzle/bloc/puzzle_bloc.dart';
import 'package:slide_puzzle/components/elevated_button.dart';

class BottomSection extends StatelessWidget {
  const BottomSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomElevatedButton(
            title: 'Shuffle',
            onPressed: () {
              context.read<PuzzleBloc>().add(PuzzleReset());
            },
          ),
          CustomElevatedButton(
            title: 'Hint',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
