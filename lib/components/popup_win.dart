import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:leave_me_alone/bloc/puzzle/puzzle_bloc.dart';
import 'package:leave_me_alone/components/animated_elevated_button.dart';
import 'package:leave_me_alone/components/animated_mask.dart';
import 'package:leave_me_alone/components/app_elevated_button.dart';
import 'package:leave_me_alone/components/audio_control_listener.dart';
import 'package:leave_me_alone/components/popup_container.dart';

import 'package:leave_me_alone/components/responsive_layout_builder.dart';
import 'package:leave_me_alone/models/puzzle.dart';

class WinPopup extends StatefulWidget {
  const WinPopup({Key? key}) : super(key: key);

  @override
  State<WinPopup> createState() => _WinPopupState();
}

class _WinPopupState extends State<WinPopup> {
  final _audioPlayer = AudioPlayer();

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final puzzle = context.select((PuzzleBloc bloc) => bloc.state.puzzle);
    final status = context.select((PuzzleBloc bloc) => bloc.state.status);
    final hasNextLevel = puzzle.getDifficulty() != PuzzleDifficulty.values.last;

    return AudioControlListener(
      audioPlayer: _audioPlayer,
      child: PopupContainer(
        child: ResponsiveLayoutBuilder(
          small: (context, child) {
            return Column(
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
                const AnimatedMask(),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: AnimatedElevatedButton(
                           width: !hasNextLevel && status == PuzzleStatus.complete
                                  ? 144
                                  : 112,
                          height: 40,
                          text: 'Play Again',
                          fontSize: 20,
                          offset: 4,
                          onPressed: () {
                            context.read<PuzzleBloc>().add(PuzzleReset());
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      Visibility(
                        visible: hasNextLevel,
                        child: Container(
                          margin: EdgeInsets.only(
                            left: hasNextLevel ? 12 : 0,
                          ),
                          child: AnimatedElevatedButton(
                            width: 112,
                            height: 40,
                            text: 'Next Level',
                            fontSize: 20,
                            offset: 4,
                            onPressed: () async {
                              final nextDifficulty = puzzle.getNextDifficulty();
                              if (nextDifficulty == PuzzleDifficulty.beta) {
                                await _audioPlayer
                                    .setAsset('assets/audio/female_cough.wav');
                              } else if (nextDifficulty == PuzzleDifficulty.delta) {
                                await _audioPlayer
                                    .setAsset('assets/audio/male_cough.wav');
                              }
                              await _audioPlayer.play();
                              await _audioPlayer.seek(Duration.zero);
                              await _audioPlayer.pause();

                              context.read<PuzzleBloc>().add(PuzzleInitialized(difficulty: nextDifficulty));

                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
          large: (context, child) {
            return Container(
              padding: const EdgeInsets.symmetric(
                vertical: 55,
              ),
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
                  const Expanded(child: AnimatedMask()),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 24,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: constraints.maxWidth * 0.1),
                                child: Center(
                                  child: AppElevatedButton(
                                    width: constraints.maxWidth * 0.8,
                                    height: 49,
                                    title: 'Play Again',
                                    fontSize: 28,
                                    onTap: () {
                                      context.read<PuzzleBloc>().add(PuzzleReset());
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Visibility(
                          visible: !(!hasNextLevel &&
                              status == PuzzleStatus.complete),
                          child: Expanded(
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: constraints.maxWidth * 0.1),
                                  child: Center(
                                    child: AppElevatedButton(
                                      width: constraints.maxWidth * 0.8,
                                      height: 49,
                                      title: 'Next Level',
                                      fontSize: 28,
                                      onTap: () async {
                                        final nextDifficulty = puzzle.getNextDifficulty();
                                        if (nextDifficulty == PuzzleDifficulty.beta) {
                                          await _audioPlayer.setAsset('assets/audio/female_cough.wav');
                                        } else if (nextDifficulty == PuzzleDifficulty.delta) {
                                          await _audioPlayer.setAsset('assets/audio/male_cough.wav');
                                        }
                                        await _audioPlayer.play();
                                        await _audioPlayer.seek(Duration.zero);
                                        await _audioPlayer.pause();

                                        context.read<PuzzleBloc>().add(PuzzleInitialized(difficulty: nextDifficulty));

                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
