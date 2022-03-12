import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_me_alone/bloc/puzzle_bloc.dart';
import 'package:leave_me_alone/components/animated_elevated_button.dart';
import 'package:leave_me_alone/components/animated_typer_text.dart';
import 'package:leave_me_alone/components/responsive_builder.dart';
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

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      mobile: Align(
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
                  child: AnimatedTyperText(
                    text: 'DIFFICULTY',
                    fontFamily: 'ThinkBig',
                    fontSize: 32,
                    initDelay: const Duration(milliseconds: 3250),
                    isAnimated: widget.isAnimated,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 32),
                  child: AnimatedTyperText(
                    key: ValueKey(_description),
                    text: _description,
                    fontSize: 24,
                    initDelay: const Duration(milliseconds: 100),
                    isAnimated: widget.isAnimated,
                  ),
                ),
                for (int i = 0; i < PuzzleDifficulty.values.length; i++)
                  Center(
                    child: LayoutBuilder(
                      builder: (context, constraints) => Container(
                        margin: const EdgeInsets.only(bottom: 48),
                        child: AnimatedElevatedButton(
                          initDelay: Duration(milliseconds: 1450 + i * 600),
                          isAnimated: widget.isAnimated,
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
                            widget.onPressedCallback?.call();
                          },
                          onHover: (bool value) {
                            setState(() {
                              _description = getDifficultyDescription(
                                  PuzzleDifficulty.values[i]);
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
      desktop: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 80),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: AnimatedTyperText(
                  text: 'DIFFICULTY',
                  fontFamily: 'ThinkBig',
                  fontSize: 72,
                  initDelay: const Duration(milliseconds: 3250),
                  isAnimated: widget.isAnimated,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 32),
                child: AnimatedTyperText(
                  key: ValueKey(_description),
                  text: _description,
                  fontSize: 36,
                  initDelay: const Duration(milliseconds: 100),
                  isAnimated: widget.isAnimated,
                ),
              ),
              for (int i = 0; i < PuzzleDifficulty.values.length; i++)
                Center(
                  child:Container(
                    margin: const EdgeInsets.only(bottom: 48),
                    child: AnimatedElevatedButton(
                      initDelay: Duration(milliseconds: 1450 + i * 600),
                      isAnimated: widget.isAnimated,
                      offset: 8.0,
                      width: max(344, MediaQuery.of(context).size.width / 1440 * 416),
                      height: max(88, MediaQuery.of(context).size.height / 1024 * 104),
                      text: PuzzleDifficulty.values[i].name.toUpperCase(),
                      fontSize: 48,
                      fontFamily: 'ThinkBig',
                      onPressed: () {
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
