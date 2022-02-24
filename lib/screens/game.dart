import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_me_alone/bloc/puzzle_bloc.dart';
import 'package:leave_me_alone/components/bottom_section.dart';
import 'package:leave_me_alone/components/page_container.dart';
import 'package:leave_me_alone/components/popup_win.dart';
import 'package:leave_me_alone/components/puzzle_board.dart';
import 'package:leave_me_alone/components/responsive_layout_builder.dart';
import 'package:leave_me_alone/components/side_section.dart';
import 'package:leave_me_alone/components/top_section.dart';
import 'package:leave_me_alone/helpers/modal_helper.dart';

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageContainer(
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
          mobile: Column(
            children: [
              const TopSection(),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Center(
                      child: PuzzleBoard(
                        dimenision: min(
                          constraints.maxWidth - 16 * 2,
                          constraints.maxHeight,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const BottomSection()
            ],
          ),
          desktop: Container(
            margin: const EdgeInsets.symmetric(horizontal: 96),
            child: Row(
              children: [
                const Expanded(
                  flex: 4,
                  child: SideSection(),
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
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
