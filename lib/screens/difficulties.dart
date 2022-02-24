import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_me_alone/bloc/puzzle_bloc.dart';
import 'package:leave_me_alone/components/elevated_button.dart';
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
        return 'Ready? Beta is coming';
      case PuzzleDifficulty.delta:
        return 'Where\'s your mask?';
      default:
        return 'You like stupid game huh';
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: const ResponsiveLayoutBuilder(
                mobile: Text(
                  'DIFFICULTY',
                  style: TextStyle(
                    fontFamily: 'ThinkBig',
                    fontSize: 32,
                  ),
                  textAlign: TextAlign.center,
                ),
                desktop: Text(
                  'DIFFICULTY',
                  style: TextStyle(
                    fontFamily: 'ThinkBig',
                    fontSize: 72,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: _showLevelDescription ? 1 : 0,
              duration: const Duration(milliseconds: 500),
              child: Container(
                key: ValueKey(_levelDescription),
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ResponsiveLayoutBuilder(
                  mobile: Text(
                    _levelDescription,
                    style: const TextStyle(
                      fontFamily: 'HandWriting',
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  desktop: Text(
                    _levelDescription,
                    style: const TextStyle(
                      fontFamily: 'HandWriting',
                      fontSize: 36,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            for (final difficulty in PuzzleDifficulty.values)
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 24),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: 264,
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: ResponsiveLayoutBuilder(
                        mobile: CustomElevatedButton(
                          title: difficulty.name,
                          fontFamily: 'ThinkBig',
                          fontSize: 32,
                          padding: const EdgeInsets.symmetric(
                            vertical: 24,
                          ),
                          onHoverCallback: (bool value) {
                            setState(() {
                              _showLevelDescription = value;
                            });
                            _levelDescription = getLevelDescription(difficulty);
                          },
                          onPressed: () {
                            context.beamToNamed('/puzzle');
                            context.read<PuzzleBloc>().add(PuzzleInitialized(difficulty: difficulty));
                          },
                        ),
                        desktop: CustomElevatedButton(
                          title: difficulty.name,
                          fontFamily: 'ThinkBig',
                          fontSize: 48,
                          padding: const EdgeInsets.symmetric(
                            vertical: 36,
                          ),
                          onHoverCallback: (bool value) {
                            setState(() {
                              _showLevelDescription = value;
                            });
                            _levelDescription = getLevelDescription(difficulty);
                          },
                          onPressed: () {
                            context.beamToNamed('/puzzle');
                            context.read<PuzzleBloc>().add(PuzzleInitialized(difficulty: difficulty));
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
