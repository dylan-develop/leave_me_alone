import 'dart:math';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_me_alone/bloc/puzzle_bloc.dart';
import 'package:leave_me_alone/components/app_elevated_button.dart';
import 'package:leave_me_alone/components/page_container.dart';
import 'package:leave_me_alone/components/responsive_builder.dart';
import 'package:leave_me_alone/models/puzzle.dart';

class DifficultiesPage extends StatefulWidget {
  const DifficultiesPage({Key? key}) : super(key: key);

  @override
  State<DifficultiesPage> createState() => _DifficultiesPageState();
}

class _DifficultiesPageState extends State<DifficultiesPage> {
  bool _showDescription = false;
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
      child: ResponsiveBuilder(
        mobile: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: const _DifficultyTitle(
                    fontSize: 32,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  child: _DifficultyDescription(
                    description: _levelDescription,
                    visible: _showDescription,
                    fontSize: 24,
                  ),
                ),
                for (final difficulty in PuzzleDifficulty.values)
                  _DifficultyButton(
                    minWidth: 309,
                    height: 80,
                    title: difficulty.name,
                    fontSize: 32,
                    onHover: (bool value) {
                      setState(() {
                        _showDescription = value;
                      });
                      _levelDescription = getLevelDescription(difficulty);
                    },
                    onTap: () {
                      context
                          .read<PuzzleBloc>()
                          .add(PuzzleInitialized(difficulty: difficulty));
                      context.beamToNamed('/puzzle');
                    },
                  ),
              ],
            ),
          ),
        ),
        desktop: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 64 * _screenHeight / 1024,
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(),
              ),
              Expanded(
                flex: 4,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          bottom: 24 * _screenHeight / 1024,
                        ),
                        child: _DifficultyTitle(
                          fontSize: min(72, 72 * _screenHeight / 1024),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          bottom: 64 * _screenHeight / 1024,
                        ),
                        child: _DifficultyDescription(
                          description: _levelDescription,
                          visible: _showDescription,
                          fontSize: min(36, 36 * _screenHeight / 1024),
                        ),
                      ),
                      for (final difficulty in PuzzleDifficulty.values)
                        _DifficultyButton(
                          minWidth: 416,
                          height: min(100, 100 * _screenHeight / 1024),
                          title: difficulty.name,
                          fontSize: min(48, 48 * _screenHeight / 1024),
                          onHover: (bool value) {
                            setState(() {
                              _showDescription = value;
                            });
                            _levelDescription = getLevelDescription(difficulty);
                          },
                          onTap: () {
                            context
                                .read<PuzzleBloc>()
                                .add(PuzzleInitialized(difficulty: difficulty));
                            context.beamToNamed('/puzzle');
                          },
                        ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DifficultyTitle extends StatelessWidget {
  final double fontSize;

  const _DifficultyTitle({
    Key? key,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'DIFFICULTY',
      style: TextStyle(
        fontFamily: 'ThinkBig',
        fontSize: fontSize,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class _DifficultyDescription extends StatelessWidget {
  final String description;
  final bool visible;
  final double fontSize;

  const _DifficultyDescription({
    Key? key,
    required this.description,
    required this.visible,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: visible ? 1 : 0,
      duration: const Duration(milliseconds: 500),
      child: Text(
        description,
        style: TextStyle(
          fontFamily: 'HandWriting',
          fontSize: fontSize,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _DifficultyButton extends StatelessWidget {
  final double minWidth;
  final double height;
  final String title;
  final double fontSize;
  final Function onTap;
  final Function(bool value) onHover;

  const _DifficultyButton({
    Key? key,
    required this.minWidth,
    required this.height,
    required this.title,
    required this.fontSize,
    required this.onTap,
    required this.onHover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 48,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return AppElevatedButton(
            width: min(minWidth, constraints.maxWidth),
            height: height,
            title: title,
            fontSize: fontSize,
            fontFamily: 'ThinkBig',
            offset: 8,
            onTap: () {
              onTap.call();
            },
            onHover: (bool value) {
              onHover.call(value);
            },
          );
        },
      ),
    );
  }
}
