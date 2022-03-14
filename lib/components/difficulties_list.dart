import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:leave_me_alone/bloc/puzzle/puzzle_bloc.dart';
import 'package:leave_me_alone/components/animated_elevated_button.dart';
import 'package:leave_me_alone/components/animated_typer_text.dart';
import 'package:leave_me_alone/components/audio_control_listener.dart';
import 'package:leave_me_alone/components/responsive_layout_builder.dart';
import 'package:leave_me_alone/helpers/audio_helper.dart';
import 'package:leave_me_alone/models/puzzle.dart';

class DifficultiesList extends StatefulWidget {
  final bool isAnimated;
  final Function? onPressedCallback;

  const DifficultiesList({
    Key? key,
    this.isAnimated = true,
    this.onPressedCallback,
  }) : super(key: key);

  @override
  State<DifficultiesList> createState() => _DifficultiesListState();
}

class _DifficultiesListState extends State<DifficultiesList> {
  final _audios = ['sneeze', 'female_cough', 'male_cough'];
  final _audioPlayer = AudioPlayer();

  String _description = 'so you like stupid game huh';

  String getDifficultyDescription(PuzzleDifficulty difficulty) {
    switch (difficulty) {
      case PuzzleDifficulty.beta:
        return 'Oh, you think you can handle this?';
      case PuzzleDifficulty.delta:
        return 'Ha! Don\'t even think about winning.';
      default:
        return 'Come on, this is way too easy.';
    }
  }

  late bool _isAnimated;

  @override
  void initState() {
    _isAnimated = widget.isAnimated;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(
      small: (context, child) => child!,
      large: (context, child) => child!,
      child: (size) {
        // style info
        final titleFontSize = size == ResponsiveLayoutSize.large ? 72.0 : 32.0;
        final descriptionFontSize =
            size == ResponsiveLayoutSize.large ? 36.0 : 24.0;
        final buttonOffset = size == ResponsiveLayoutSize.large ? 8.0 : 4.0;
        final buttonWidth = size == ResponsiveLayoutSize.large ? 416.0 : 309.0;
        final buttonHeight = size == ResponsiveLayoutSize.large ? 104.0 : 80.0;
        final buttonFontSize = size == ResponsiveLayoutSize.large ? 48.0 : 32.0;

        // animation info
        final buttonsDelay =
            Duration(milliseconds: _description.length * 40 + 250);
        final titleDelay =
            buttonsDelay + const Duration(milliseconds: 500 + 250);

        return AudioControlListener(
          audioPlayer: _audioPlayer,
          child: Padding(
            key: ValueKey(size),
            padding: const EdgeInsets.only(top: 80),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: AnimatedTyperText(
                      text: 'DIFFICULTY',
                      fontFamily: 'ThinkBig',
                      fontSize: titleFontSize,
                      initDelay: titleDelay,
                      isAnimated: _isAnimated,
                    ),
                  ),
                  Visibility(
                    visible: _description == 'so you like stupid game huh',
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 32),
                      child: AnimatedTyperText(
                        text: 'so you like stupid game huh',
                        fontSize: descriptionFontSize,
                        isAnimated: _isAnimated,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _description != 'so you like stupid game huh',
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 32),
                      child: Text(
                        _description,
                        style: TextStyle(
                            fontSize: descriptionFontSize,
                            fontFamily: 'HandWriting'),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  for (int i = 0; i < PuzzleDifficulty.values.length; i++)
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 48),
                        child: AnimatedElevatedButton(
                          offset: buttonOffset,
                          width: buttonWidth,
                          height: buttonHeight,
                          text: PuzzleDifficulty.values[i].name.toUpperCase(),
                          fontSize: buttonFontSize,
                          fontFamily: 'ThinkBig',
                          onPressed: () async {
                            await _audioPlayer
                                .setAsset('assets/audio/${_audios[i]}.wav');
                            await _audioPlayer.replay();

                            context.read<PuzzleBloc>().add(PuzzleInitialized(
                                difficulty: PuzzleDifficulty.values[i]));
                            widget.onPressedCallback?.call();
                          },
                          onHover: (bool value) {
                            setState(() {
                              _description = getDifficultyDescription(
                                  PuzzleDifficulty.values[i]);
                            });
                          },
                          initDelay: buttonsDelay,
                          isAnimated: _isAnimated,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
