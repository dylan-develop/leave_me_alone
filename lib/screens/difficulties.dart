import 'dart:math';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_me_alone/bloc/puzzle_bloc.dart';
import 'package:leave_me_alone/components/app_elevated_button.dart';
import 'package:leave_me_alone/components/page_container.dart';
import 'package:leave_me_alone/components/responsive_layout_builder.dart';
import 'package:leave_me_alone/models/puzzle.dart';

class DifficultiesPage extends StatefulWidget {
  const DifficultiesPage({Key? key}) : super(key: key);

  @override
  State<DifficultiesPage> createState() => _DifficultiesPageState();
}

class _DifficultiesPageState extends State<DifficultiesPage> {
  bool _showLevelDescription = false;
  String _levelDescription = '';

  String getLevelDescription(PuzzleDifficulty difficulty) {
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
    final _screenHeight = MediaQuery.of(context).size.height;

    return PageContainer(
      child: ResponsiveLayoutBuilder(
        mobile: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 32,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'DIFFICULTY',
                      style: TextStyle(
                        fontFamily: 'ThinkBig',
                        fontSize: 32,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    AnimatedOpacity(
                      opacity: _showLevelDescription ? 1 : 0,
                      duration: const Duration(milliseconds: 500),
                      child: Text(
                        _levelDescription,
                        style: const TextStyle(
                          fontFamily: 'HandWriting',
                          fontSize: 24,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              for (final level in PuzzleDifficulty.values)
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return AppElevatedButton(
                        width: constraints.maxWidth,
                        height: _screenHeight * 0.125,
                        title: level.name,
                        fontSize: 32,
                        fontFamily: 'ThinkBig',
                        onTap: () {
                          context.beamToNamed('/puzzle');
                          context
                              .read<PuzzleBloc>()
                              .add(PuzzleInitialized(difficulty: level));
                        },
                        onHover: (bool value) {
                          setState(() {
                            if (value) {
                              _showLevelDescription = true;
                            } else {
                              _showLevelDescription = false;
                            }
                          });
                          _levelDescription = getLevelDescription(level);
                        },
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
        desktop: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(),
            ),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'DIFFICULTY',
                          style: TextStyle(
                            fontFamily: 'ThinkBig',
                            fontSize: min(72, 72 * _screenHeight / 1024),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        AnimatedOpacity(
                          opacity: _showLevelDescription ? 1 : 0,
                          duration: const Duration(milliseconds: 500),
                          child: Text(
                            _levelDescription,
                            style: TextStyle(
                              fontFamily: 'HandWriting',
                              fontSize: min(36, 36 * _screenHeight / 1024),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  for (final level in PuzzleDifficulty.values)
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 64),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return AppElevatedButton(
                              width: constraints.maxWidth,
                              height: _screenHeight * 0.125,
                              title: level.name,
                              fontSize: min(48, 48 * _screenHeight / 1024),
                              fontFamily: 'ThinkBig',
                              onTap: () {
                                context.beamToNamed('/puzzle');
                                context
                                    .read<PuzzleBloc>()
                                    .add(PuzzleInitialized(difficulty: level));
                              },
                              onHover: (bool value) {
                                setState(() {
                                  if (value) {
                                    _showLevelDescription = true;
                                  } else {
                                    _showLevelDescription = false;
                                  }
                                });
                                _levelDescription = getLevelDescription(level);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
