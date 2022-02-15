import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:slide_puzzle/components/puzzle_tile.dart';

class PuzzleBoard extends StatefulWidget {
  const PuzzleBoard({Key? key}) : super(key: key);

  @override
  State<PuzzleBoard> createState() => _PuzzleBoardState();
}

class _PuzzleBoardState extends State<PuzzleBoard> {
  List<int> order = [];

  bool checkWin(List<int> order) {
    var temp = [...this.order]..sort();
    print('check win: ${listEquals(temp, order)}');
    return listEquals(temp, order);
  }

  @override
  void initState() {
    order = [for (int i = 0; i < 16; i++) i]
      ..shuffle()
      ..remove(15)
      ..add(15);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GridView.count(
          crossAxisCount: 4,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          shrinkWrap: true,
          children: [
            for (int puzzleIndex in order)
              PuzzleTile(
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
