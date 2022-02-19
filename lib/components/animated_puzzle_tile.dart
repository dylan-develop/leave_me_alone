import 'package:flutter/material.dart';
import 'dart:math';

class AnimatedPuzzleTile extends StatefulWidget {
  final List<int> order;
  final int value;
  final Function onTap;

  const AnimatedPuzzleTile({
    Key? key,
    required this.order,
    required this.value,
    required this.onTap,
  }) : super(key: key);

  @override
  State<AnimatedPuzzleTile> createState() => _AnimatedPuzzleTileState();
}

class _AnimatedPuzzleTileState extends State<AnimatedPuzzleTile> {
  @override
  Widget build(BuildContext context) {
    print(
        'build: #${widget.value} [${widget.order.indexOf(widget.value) % 3 / 2}, ${(widget.order.indexOf(widget.value) / 3).floor() / 2}]');
    return Visibility(
      visible: widget.value != widget.order.reduce(max),
      child: GestureDetector(
        onTap: () {
          if (widget.value != widget.order.reduce(max)) {
            final int index = widget.order.indexOf(widget.value);
            final int puzzleRows = sqrt(widget.order.length).round();
            final int maxPuzzleIndex = widget.order.reduce(max);
            final int whiteIndex =
                widget.order.indexOf(widget.order.reduce(max));
            if ((index + 1 < widget.order.length &&
                    widget.order[index + 1] == maxPuzzleIndex &&
                    (index + 1) % puzzleRows != 0) ||
                (index - 1 >= 0 &&
                    widget.order[index - 1] == maxPuzzleIndex &&
                    index % puzzleRows != 0) ||
                (index + puzzleRows < widget.order.length &&
                    widget.order[index + puzzleRows] == maxPuzzleIndex) ||
                (index - puzzleRows >= 0 &&
                    widget.order[index - puzzleRows] == maxPuzzleIndex)) {
              setState(() {
                widget.order[whiteIndex] = widget.order[index];
                widget.order[index] = maxPuzzleIndex;
              });
            }
          }
          widget.onTap.call(widget.order);
        },
        child: AnimatedAlign(
          duration: const Duration(seconds: 1),
          alignment: FractionalOffset(
            widget.order.indexOf(widget.value) % 3 / 2,
            (widget.order.indexOf(widget.value) / 3).floor() / 2,
          ),
          child: SizedBox.square(
            dimension: 500 / 3,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
                color: widget.value % 2 == 0 ? Colors.red : Colors.blue,
              ),
              child: Center(
                child: Text(
                  widget.value % 2 == 0
                      ? 'Character #${widget.value}'
                      : 'Social Distance #${widget.value}',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
