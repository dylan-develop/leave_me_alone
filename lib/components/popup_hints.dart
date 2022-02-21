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
          Container(
            margin: const EdgeInsets.only(bottom: 32),
            child: const Text(
              'YOUR HINT',
              style: TextStyle(
                fontSize: 36,
                fontFamily: 'ThinkBig',
              ),
            ),
          ),
          Flexible(
            child: LayoutBuilder(
              builder: ((context, constraints) {
                return PuzzleBoard(
                  isReadOnly: true,
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
