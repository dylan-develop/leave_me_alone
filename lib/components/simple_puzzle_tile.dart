import 'package:flutter/material.dart';
import 'dart:math';

class SimplePuzzleTile extends StatelessWidget {
  final List<int> order;
  final int index;
  final Function onTap;

  const SimplePuzzleTile({
    Key? key,
    required this.order,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (index != order.reduce(max)) {
          onTap.call();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
          color: index == order.reduce(max) ? Colors.white : index % 2 == 0 ? Colors.red : Colors.blue,
        ),
        child: Center(
          child: Text(index == order.reduce(max) ? '' : index % 2 == 0 ? 'Character' : 'Social Distance'),
        ),
      ),
    );
  }
}
