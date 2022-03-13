import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:leave_me_alone/components/animated_character_block.dart';
import 'package:leave_me_alone/components/animated_elevated_button.dart';
import 'package:leave_me_alone/components/animated_typer_text.dart';
import 'package:leave_me_alone/components/audio_control.dart';
import 'package:leave_me_alone/components/audio_control_listener.dart';

import 'package:leave_me_alone/components/responsive_layout_builder.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({Key? key}) : super(key: key);

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  final _audioPlayer = AudioPlayer();

  @override
  void initState() {
    _audioPlayer.setAsset('assets/audio/sneeze.wav');
    super.initState();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AudioControlListener(
        audioPlayer: _audioPlayer,
        child: ResponsiveLayoutBuilder(
          child: (size) {
            final width = size == ResponsiveLayoutSize.large ? null : 264.0;
            final titleFontSize =
                size == ResponsiveLayoutSize.large ? 96.0 : 48.0;
            final descriptionFontSize =
                size == ResponsiveLayoutSize.large ? 36.0 : 24.0;
            final buttonOffset = size == ResponsiveLayoutSize.large ? 8.0 : 4.0;
            final buttonFontSize =
                size == ResponsiveLayoutSize.large ? 36.0 : 24.0;
            final buttonHeight =
                size == ResponsiveLayoutSize.large ? 56.0 : 40.0;

            return Center(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: AnimatedTyperText(
                          text: 'LEAVE ME ALONE',
                          fontFamily: 'ThinkBig',
                          fontSize: titleFontSize,
                          initDelay: const Duration(milliseconds: 1700),
                        ),
                      ),
                      AnimatedTyperText(
                        text: 'A stupid game',
                        fontSize: descriptionFontSize,
                        initDelay: const Duration(milliseconds: 2400),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 64),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Expanded(
                              flex: 5,
                              child: AnimatedCharacterBlock(
                                index: 1,
                                initDelay: Duration(milliseconds: 200),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(),
                            ),
                            const Expanded(
                              flex: 5,
                              child: AnimatedCharacterBlock(
                                index: 2,
                                initDelay: Duration(milliseconds: 700),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: LayoutBuilder(
                          builder: (context, constraints) =>
                              AnimatedElevatedButton(
                            initDelay: const Duration(milliseconds: 3050),
                            offset: buttonOffset,
                            width: constraints.maxWidth,
                            height: buttonHeight,
                            text: 'Start Now',
                            fontSize: buttonFontSize,
                            onPressed: () async {
                              await _audioPlayer.play();
                              context.beamToNamed('/difficulties');
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          small: (context, child) {
            return Stack(
              children: [
                child!,
                const Positioned(
                  right: 32,
                  top: 32,
                  child: AudioControl(),
                ),
              ],
            );
          },
          large: (context, child) {
            return Stack(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 5,
                      child: child!,
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(),
                    ),
                  ],
                ),
                const Positioned(
                  right: 32,
                  top: 32,
                  child: AudioControl(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
