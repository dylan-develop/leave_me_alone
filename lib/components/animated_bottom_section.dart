import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:leave_me_alone/bloc/puzzle/puzzle_bloc.dart';
import 'package:leave_me_alone/components/animated_elevated_button.dart';
import 'package:leave_me_alone/components/audio_control_listener.dart';
import 'package:leave_me_alone/components/popup_hints.dart';
import 'package:leave_me_alone/helpers/modal_helper.dart';
import 'package:leave_me_alone/models/puzzle.dart';

class AnimatedBottomSection extends StatefulWidget {
  const AnimatedBottomSection({Key? key}) : super(key: key);

  @override
  State<AnimatedBottomSection> createState() => _AnimatedBottomSectionState();
}

class _AnimatedBottomSectionState extends State<AnimatedBottomSection> {
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
    final stage = context.select((PuzzleBloc bloc) => bloc.state.stage);

    final initDelay = 500 + puzzle.getDimension() * 250;

    return AudioControlListener(
      audioPlayer: _audioPlayer,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: !(!puzzle.hasNextDifficulty() &&
                  status == PuzzleStatus.complete),
              child: Container(
                margin: const EdgeInsets.only(right: 24),
                child: AnimatedElevatedButton(
                  key: ValueKey(status),
                  width: 136,
                  height: 40,
                  text: puzzle.hasNextDifficulty() &&
                          status == PuzzleStatus.complete
                      ? 'Next Level'
                      : 'Shuffle',
                  fontSize: 24,
                  offset: 4,
                  initDelay: Duration(
                    milliseconds: stage == PuzzleStage.initialized
                        ? initDelay +
                            puzzle.getDifficulty().name.length * 50 +
                            2000 +
                            500
                        : 0,
                  ),
                  onPressed: () async {
                    if (puzzle.hasNextDifficulty() &&
                        status == PuzzleStatus.complete) {
                      final nextDifficulty = puzzle.getNextDifficulty();
                      if (nextDifficulty == PuzzleDifficulty.beta) {
                        await _audioPlayer
                            .setAsset('assets/audio/female_cough.wav');
                      } else if (nextDifficulty == PuzzleDifficulty.delta) {
                        await _audioPlayer
                            .setAsset('assets/audio/male_cough.wav');
                      }
                      context
                          .read<PuzzleBloc>()
                          .add(PuzzleInitialized(difficulty: nextDifficulty));
                    } else {
                      await _audioPlayer.setAsset('assets/audio/sneeze.wav');
                      await _audioPlayer.play();
                      await _audioPlayer.seek(Duration.zero);
                      await _audioPlayer.pause();
                      context.read<PuzzleBloc>().add(PuzzleReset());
                    }
                  },
                ),
              ),
            ),
            AnimatedElevatedButton(
              key: ValueKey(status),
              width: status == PuzzleStatus.complete ? 136 : 80,
              height: 40,
              text: status == PuzzleStatus.complete ? 'Play Again' : 'Hint',
              fontSize: 24,
              offset: 4,
              initDelay: Duration(
                  milliseconds: stage == PuzzleStage.initialized
                      ? initDelay +
                          puzzle.getDifficulty().name.length * 50 +
                          2000 +
                          500
                      : 0),
              onPressed: () {
                if (status == PuzzleStatus.complete) {
                  context.read<PuzzleBloc>().add(PuzzleReset());
                } else {
                  showSlideDialog(
                    context: context,
                    child: const HintsPopup(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
