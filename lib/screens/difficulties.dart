import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slide_puzzle/bloc/puzzle_bloc.dart';
import 'package:slide_puzzle/components/elevated_button.dart';
import 'package:slide_puzzle/components/page_container.dart';
import 'package:slide_puzzle/components/responsive_layout_builder.dart';
import 'package:slide_puzzle/models/puzzle.dart';

class DifficultiesPage extends StatelessWidget {
  const DifficultiesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      child: ResponsiveLayoutBuilder(
        mobile: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: constraints.maxWidth * 0.2,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(
                          bottom: 16,
                        ),
                        child: const Text(
                          'Difficulty',
                          style: TextStyle(
                            fontSize: 32,
                            fontFamily: 'ThinkBig',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    for (final difficulty in PuzzleDifficulty.values)
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 24),
                        child: CustomElevatedButton(
                          title: difficulty.name,
                          fontFamily: 'ThinkBig',
                          fontSize: 32,
                          padding: const EdgeInsets.symmetric(
                            vertical: 24,
                          ),
                          onPressed: () {
                            context.read<PuzzleBloc>().add(PuzzleInitialized(difficulty: difficulty));
                            context.beamToNamed('/puzzle');
                          },
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
        desktop: Row(
          children: [
            Expanded(
              child: Container(),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(
                            bottom: 16,
                          ),
                          child: const Text(
                            'Difficulty',
                            style: TextStyle(
                              fontSize: 72,
                              fontFamily: 'ThinkBig',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      for (final difficulty in PuzzleDifficulty.values)
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 24),
                          child: CustomElevatedButton(
                            title: difficulty.name,
                            fontFamily: 'ThinkBig',
                            fontSize: 48,
                            padding: const EdgeInsets.symmetric(
                              vertical: 24,
                            ),
                            onPressed: () {
                              context.read<PuzzleBloc>().add(
                                  PuzzleInitialized(difficulty: difficulty));
                              context.beamToNamed('/puzzle');
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
