import 'dart:math';

import 'package:flutter/material.dart';
import 'package:slide_puzzle/components/popup_container.dart';
import 'package:slide_puzzle/components/puzzle_board.dart';

class HintsPopup extends StatelessWidget {
  const HintsPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LayoutBuilder(builder: ((context, constraints) {
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    'YOUR HINT',
                    style: TextStyle(
                      fontSize: constraints.maxWidth > 768 ? 36 : 32,
                      fontFamily: 'ThinkBig',
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 32),
                  child: Text(
                    'psst.....There is more than one way to win',
                    style: TextStyle(
                      fontSize: constraints.maxWidth > 768 ? 24 : 20,
                      fontFamily: 'HandWriting',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            );
          })),
          Flexible(
            child: LayoutBuilder(
              builder: ((context, constraints) {
                return PuzzleBoard(
                  isHints: true,
                  dimenision: min(
                    constraints.maxWidth,
                    constraints.maxHeight,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
