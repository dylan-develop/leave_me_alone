import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slide_puzzle/bloc/puzzle_bloc.dart';
import 'package:slide_puzzle/components/elevated_button.dart';
import 'package:slide_puzzle/components/popup_container.dart';
import 'package:slide_puzzle/components/responsive_layout_builder.dart';

class WinPopup extends StatelessWidget {
  const WinPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final difficulty = context.read<PuzzleBloc>().state.puzzle.getDifficulty();

    return PopupContainer(
      child: ResponsiveLayoutBuilder(
        mobile: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 32),
                  child: const Text(
                    'CONGRATZ',
                    style: TextStyle(
                      fontSize: 36,
                      fontFamily: 'ThinkBig',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 32),
                  child: const Text(
                    'Here\'s a mask for you :)',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'HandWriting',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Image.asset(
                kIsWeb ? 'images/mask.png' : 'assets/images/mask.gif',
              ),
              CustomElevatedButton(
                title: difficulty != PuzzleStatus.values.last
                    ? 'Done'
                    : 'Next level',
                onPressed: () {},
              ),
            ],
          ),
        ),
        desktop: Container(
          padding: const EdgeInsets.symmetric(horizontal: 55),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 32),
                  child: const Text(
                    'CONGRATZ',
                    style: TextStyle(
                      fontSize: 48,
                      fontFamily: 'ThinkBig',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 32),
                  child: const Text(
                    'Here\'s a mask for you :)',
                    style: TextStyle(
                      fontSize: 32,
                      fontFamily: 'HandWriting',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Image.asset(
                kIsWeb ? 'images/mask.png' : 'assets/images/mask.png',
              ),
              CustomElevatedButton(
                title: difficulty != PuzzleStatus.values.last
                    ? 'Done'
                    : 'Next level',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
