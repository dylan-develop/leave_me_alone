import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slide_puzzle/components/puzzle_tile.dart';

import 'animated_puzzle_tile.dart';

class AnimatedPuzzleBoard extends StatefulWidget {
  const AnimatedPuzzleBoard({Key? key}) : super(key: key);

  @override
  State<AnimatedPuzzleBoard> createState() => _AnimatedPuzzleBoardState();
}

class _AnimatedPuzzleBoardState extends State<AnimatedPuzzleBoard> {
  List<int> order = [];

  bool checkWin(List<int> order) {
    for (int i = 0; i < order.length; i++) {
      if (i % 2 != order[i] % 2) {
        return false;
      }
    }
    print('win');
    showDialog(
      context: context,
      builder: (context) => const CupertinoAlertDialog(
        title: Text('WIN'),
      ),
    );
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
    return SizedBox.square(
      dimension: 500,
      child: Container(
        color: Colors.orange,
        child: Stack(
          children: [
            for (int i = 0; i < order.length; i++)
              AnimatedPuzzleTile(
                order: order,
                value: order[i],
                onTap: (List<int> order) {
                  checkWin(order);
                },
              ),
          ],
        ),
      ),
    );
  }
}
