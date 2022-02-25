import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_me_alone/bloc/puzzle_bloc.dart';
import 'package:leave_me_alone/components/app_elevated_button.dart';
import 'package:leave_me_alone/components/popup_container.dart';
import 'package:leave_me_alone/components/responsive_layout_builder.dart';
import 'package:leave_me_alone/models/puzzle.dart';

class WinPopup extends StatelessWidget {
  const WinPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final puzzle = context.select((PuzzleBloc bloc) => bloc.state.puzzle);
    final status = context.select((PuzzleBloc bloc) => bloc.state.status);
    final hasNextLevel = puzzle.getDifficulty() != PuzzleDifficulty.values.last;

    return PopupContainer(
      child: ResponsiveLayoutBuilder(
        mobile: Column(
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
              kIsWeb ? 'assets/images/mask.png' : 'assets/images/mask.gif',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: AppElevatedButton(
                    width: !hasNextLevel && status == PuzzleStatus.complete
                        ? 144
                        : 112,
                    height: 40,
                    title: 'Play Again',
                    fontSize: 20,
                    onTap: () {
                      context.read<PuzzleBloc>().add(PuzzleReset());
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: hasNextLevel ? 12 : 0,
                  ),
                  child: AppElevatedButton(
                    width: hasNextLevel ? 112 : 0,
                    height: 40,
                    title: 'Next Level',
                    fontSize: 20,
                    onTap: () {
                      context.read<PuzzleBloc>().add(PuzzleInitialized(
                          difficulty: puzzle.getNextDifficulty()));
                    },
                  ),
                ),
              ],
            ),
          ],
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
                  kIsWeb ? 'assets/images/mask.png' : 'assets/images/mask.gif',
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppElevatedButton(
                    width: !hasNextLevel && status == PuzzleStatus.complete
                        ? 296
                        : 204,
                    height: 56,
                    title: 'Play Again',
                    fontSize: 36,
                    onTap: () {
                      context.read<PuzzleBloc>().add(PuzzleReset());
                      Navigator.of(context).pop();
                    },
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: hasNextLevel ? 24 : 0,
                    ),
                    child: AppElevatedButton(
                      width: hasNextLevel ? 204 : 0,
                      height: 56,
                      title: 'Next Level',
                      fontSize: 36,
                      onTap: () {
                        context.read<PuzzleBloc>().add(PuzzleInitialized(
                            difficulty: puzzle.getNextDifficulty()));
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
