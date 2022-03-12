import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_me_alone/bloc/puzzle_bloc.dart';
import 'package:leave_me_alone/components/animated_bottom_section.dart';
import 'package:leave_me_alone/components/animated_side_section.dart';
import 'package:leave_me_alone/components/animated_top_section.dart';
import 'package:leave_me_alone/components/page_container.dart';
import 'package:leave_me_alone/components/popup_win.dart';
import 'package:leave_me_alone/components/puzzle_board.dart';

import 'package:leave_me_alone/components/responsive_layout_builder.dart';
import 'package:leave_me_alone/helpers/modal_helper.dart';

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _focusNode = FocusNode()..requestFocus();

    return KeyboardListener(
      focusNode: _focusNode,
      onKeyEvent: (event) {
        final puzzle = context.read<PuzzleBloc>().state.puzzle;
        final physicalKey = event.physicalKey;
        if (event is KeyDownEvent) {
          if (physicalKey == PhysicalKeyboardKey.arrowUp) {
            final tile =
                puzzle.getTileRelativeToWhitespaceTile(const Offset(0, 1));
            if (tile != null) {
              context.read<PuzzleBloc>().add(TileTapped(tile));
            }
          } else if (physicalKey == PhysicalKeyboardKey.arrowDown) {
            final tile =
                puzzle.getTileRelativeToWhitespaceTile(const Offset(0, -1));
            if (tile != null) {
              context.read<PuzzleBloc>().add(TileTapped(tile));
            }
          } else if (physicalKey == PhysicalKeyboardKey.arrowLeft) {
            final tile =
                puzzle.getTileRelativeToWhitespaceTile(const Offset(1, 0));
            if (tile != null) {
              context.read<PuzzleBloc>().add(TileTapped(tile));
            }
          } else if (physicalKey == PhysicalKeyboardKey.arrowRight) {
            final tile =
                puzzle.getTileRelativeToWhitespaceTile(const Offset(-1, 0));
            if (tile != null) {
              context.read<PuzzleBloc>().add(TileTapped(tile));
            }
          }
        }
      },
      child: PageContainer(
        child: BlocListener<PuzzleBloc, PuzzleState>(
          listener: (context, state) {
            if (state.status == PuzzleStatus.complete) {
              Future.delayed(const Duration(milliseconds: 800), () {
                showSlideDialog(
                  context: context,
                  child: const WinPopup(),
                );
              });
            }
          },
          child: ResponsiveLayoutBuilder(
            small: (context, child) {
              return Column(
                children: [
                  const AnimatedTopSection(),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Center(
                          child: PuzzleBoard(
                            dimenision: min(
                              constraints.maxWidth - 16,
                              constraints.maxHeight,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const AnimatedBottomSection()
                ],
              );
            },
            large: (context, child) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 96),
                child: Row(
                  children: [
                    const Expanded(
                      flex: 4,
                      child: AnimatedSideSection(),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 6,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Center(
                            child: PuzzleBoard(
                              dimenision: min(
                                    constraints.maxWidth,
                                    constraints.maxHeight,
                                  ) -
                                  16 * 2,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
