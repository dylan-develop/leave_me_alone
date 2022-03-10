import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leave_me_alone/components/simple_puzzle_tile2.dart';

class SimplePuzzleBoard2 extends StatefulWidget {
  const SimplePuzzleBoard2({Key? key}) : super(key: key);

  @override
  State<SimplePuzzleBoard2> createState() => _SimplePuzzleBoard2State();
}

class _SimplePuzzleBoard2State extends State<SimplePuzzleBoard2> {
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
              SimplePuzzleTile2(
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
