import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_me_alone/bloc/puzzle_bloc.dart';
import 'package:leave_me_alone/components/animated_elevated_button.dart';
import 'package:leave_me_alone/components/animated_icon_button.dart';
import 'package:leave_me_alone/components/animated_text_button.dart';
import 'package:leave_me_alone/components/animated_typer_text.dart';
import 'package:leave_me_alone/components/responsive_layout_builder.dart';
import 'package:leave_me_alone/models/puzzle.dart';

class DifficultiesPage extends StatefulWidget {
  const DifficultiesPage({Key? key}) : super(key: key);

  @override
  State<DifficultiesPage> createState() => _DifficultiesPageState();
}

class _DifficultiesPageState extends State<DifficultiesPage> {
  String _difficultyDescription = 'so you like stupid game huh';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayoutBuilder(
        mobile: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 80),
                child: SizedBox(
                  width: 309,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: const AnimatedTyperText(
                          text: 'DIFFICULTY',
                          fontFamily: 'ThinkBig',
                          fontSize: 32,
                          initDelay: Duration(milliseconds: 3250),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 32),
                        child: AnimatedTyperText(
                          key: ValueKey(_difficultyDescription),
                          text: _difficultyDescription,
                          fontSize: 24,
                          initDelay: const Duration(milliseconds: 100),
                        ),
                      ),
                      for (int i = 0; i < PuzzleDifficulty.values.length; i++)
                          Center(
                            child: LayoutBuilder(
                              builder: (context, constraints) => Container(
                                margin: const EdgeInsets.only(bottom: 48),
                                child: AnimatedElevatedButton(
                                  initDelay: Duration(milliseconds: 1450 + i * 600),
                                  offset: 4.0,
                                  width: constraints.maxWidth,
                                  height: MediaQuery.of(context).size.height / 812 * 80,
                                  text: PuzzleDifficulty.values[i].name.toUpperCase(),
                                  fontSize: 32,
                                  fontFamily: 'ThinkBig',
                                  onPressed: () {
                                    context.read<PuzzleBloc>().add(PuzzleInitialized(
                                      difficulty: PuzzleDifficulty.values[i],
                                    ));
                                    context.beamToNamed('/puzzle');
                                  },
                                  onHover: (bool value) {
                                    setState(() {
                                      _difficultyDescription = getDifficultyDescription(PuzzleDifficulty.values[i]);
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                    ],
                  ),
                ),
              ),
            ), 
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              child: AnimatedIconButton(
                initDelay: const Duration(milliseconds: 3750),
                imageUrl: 'assets/icons/arrow.svg',
                onPressed: () {
                  context.beamToNamed('/');
                },
              ),
            ),
          ],
        ),
        desktop: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(),
                ),
                Expanded(
                  flex: 5,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 80),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          child: const AnimatedTyperText(
                            text: 'DIFFICULTY',
                            fontFamily: 'ThinkBig',
                            fontSize: 72,
                            initDelay: Duration(milliseconds: 3250),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 32),
                          child: AnimatedTyperText(
                            key: ValueKey(_difficultyDescription),
                            text: _difficultyDescription,
                            fontSize: 36,
                            initDelay: const Duration(milliseconds: 100),
                          ),
                        ),
                        for (int i = 0; i < PuzzleDifficulty.values.length; i++)
                          Center(
                            child: LayoutBuilder(
                              builder: (context, constraints) => Container(
                                margin: const EdgeInsets.only(bottom: 48),
                                child: AnimatedElevatedButton(
                                  initDelay: Duration(milliseconds: 1450 + i * 600),
                                  offset: 8.0,
                                  width: constraints.maxWidth,
                                  height: MediaQuery.of(context).size.height / 1024 * 104,
                                  text: PuzzleDifficulty.values[i].name.toUpperCase(),
                                  fontSize: 48,
                                  fontFamily: 'ThinkBig',
                                  onPressed: () {
                                    context.read<PuzzleBloc>().add(PuzzleInitialized(difficulty: PuzzleDifficulty.values[i]));
                                    context.beamToNamed('/puzzle');
                                  },
                                  onHover: (bool value) {
                                    setState(() {
                                      _difficultyDescription = getDifficultyDescription(PuzzleDifficulty.values[i]);
                                      print(_difficultyDescription);
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 32,
                horizontal: 96,
              ),
              child: AnimatedTextButton(
                initDelay: const Duration(milliseconds: 3750),
                text: 'HOME',
                onPressed: () {
                  context.beamToNamed('/');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}