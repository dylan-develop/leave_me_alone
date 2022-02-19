import 'dart:math';

import 'package:flutter/material.dart';
import 'package:slide_puzzle/components/simple_puzzle_tile.dart';

class SimplePuzzleBoard extends StatefulWidget {
  const SimplePuzzleBoard({Key? key}) : super(key: key);

  @override
  State<SimplePuzzleBoard> createState() => _SimplePuzzleBoardState();
}

class _SimplePuzzleBoardState extends State<SimplePuzzleBoard> {
  List<int> order = [];

  bool checkWin(List<int> order) {
    for (int i = 0 ; i < order.length; i++) {
      if (i % 2 != order[i] % 2) {
        return false;
      }
    }
    print('win');
    return true;
  }

  @override
  void initState() {
    order = [for (int i = 0; i < 9; i++) i]
      ..shuffle()
      ..remove(8)
      ..add(8);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          shrinkWrap: true,
          children: [
            for (int puzzleIndex in order)
              SimplePuzzleTile(
                order: order,
                index: puzzleIndex,
                onTap: () {
                  final int index = order.indexOf(puzzleIndex);
                  final int puzzleRows = sqrt(order.length).round();
                  final int maxPuzzleIndex = order.reduce(max);
                  final int whiteIndex = order.indexOf(order.reduce(max));

                  if ((index + 1 < order.length &&
                          order[index + 1] == maxPuzzleIndex &&
                          (index + 1) % puzzleRows != 0) ||
                      (index - 1 >= 0 &&
                          order[index - 1] == maxPuzzleIndex &&
                          index % puzzleRows != 0) ||
                      (index + puzzleRows < order.length &&
                          order[index + puzzleRows] == maxPuzzleIndex) ||
                      (index - puzzleRows >= 0 &&
                          order[index - puzzleRows] == maxPuzzleIndex)) {
                    setState(() {
                      order[whiteIndex] = order[index];
                      order[index] = maxPuzzleIndex;
                    });
                  }

                  checkWin(order);
                },
              ),
          ],
        ),
      ],
    );
  }
}
