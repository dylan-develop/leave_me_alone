import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slide_puzzle/bloc/puzzle_bloc.dart';
import 'package:slide_puzzle/components/elevated_button.dart';
import 'package:slide_puzzle/components/popup_container.dart';
import 'package:slide_puzzle/components/responsive_layout_builder.dart';
import 'package:slide_puzzle/models/puzzle.dart';

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
              Visibility(
                visible: difficulty != PuzzleStatus.values.last,
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  child: CustomElevatedButton(
                    title: 'Next level',
                    onPressed: () {
                      context.read<PuzzleBloc>().add(
                            PuzzleInitialized(
                              difficulty: PuzzleDifficulty.values[
                                  PuzzleDifficulty.values.indexOf(difficulty) +
                                      1],
                            ),
                          );
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  child: CustomElevatedButton(
                    title: 'Play again',
                    onPressed: () {
                      context.read<PuzzleBloc>().add(PuzzleReset());
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
              Visibility(
                visible: difficulty == PuzzleStatus.values.last,
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: CustomElevatedButton(
                      title: 'Done',
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
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
              Expanded(
                child: Image.asset(
                  kIsWeb ? 'images/mask.png' : 'assets/images/mask.png',
                ),
              ),
              Visibility(
                visible: difficulty != PuzzleStatus.values.last,
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    child: CustomElevatedButton(
                      title: 'Next level',
                      fontSize: 36,
                      padding: const EdgeInsets.symmetric(horizontal: 72),
                      onPressed: () {
                        context.read<PuzzleBloc>().add(PuzzleInitialized(
                              difficulty: PuzzleDifficulty.values[
                                  PuzzleDifficulty.values.indexOf(difficulty) +
                                      1],
                            ));
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  child: CustomElevatedButton(
                    title: 'Play again',
                    fontSize: 36,
                    padding: const EdgeInsets.symmetric(horizontal: 72),
                    onPressed: () {
                      context.read<PuzzleBloc>().add(PuzzleReset());
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
              Visibility(
                visible: difficulty == PuzzleStatus.values.last,
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: CustomElevatedButton(
                      title: 'Done',
                      fontSize: 36,
                      padding: const EdgeInsets.symmetric(horizontal: 72),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
