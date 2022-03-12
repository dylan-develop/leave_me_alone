import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_me_alone/bloc/puzzle/puzzle_bloc.dart';

class AnimatedMovesNumber extends StatefulWidget {
  final Duration initDelay;
  final bool isAnimated;
  final double fontSize;

  const AnimatedMovesNumber({
    Key? key,
    this.initDelay = Duration.zero,
    this.isAnimated = true,
    this.fontSize = 24,
  }) : super(key: key);

  @override
  State<AnimatedMovesNumber> createState() => _AnimatedMovesNumberState();
}

class _AnimatedMovesNumberState extends State<AnimatedMovesNumber> {
  double _opacity = 0;

  @override
  void initState() {
    Future.delayed(widget.isAnimated ? widget.initDelay : Duration.zero, () {
      setState(() {
        _opacity = 1;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final status = context.select((PuzzleBloc bloc) => bloc.state.status);
    final moves = context.select((PuzzleBloc bloc) => bloc.state.numberOfMoves);

    return AnimatedOpacity(
      opacity: _opacity,
      duration: Duration(milliseconds: widget.isAnimated ? 500 : 0),
      child: Container(
        margin: const EdgeInsets.only(bottom: 40),
        child: Wrap(
          children: [
            AnimatedOpacity(
              opacity: status == PuzzleStatus.complete ? 1 : 0,
              duration: const Duration(milliseconds: 500),
              child: Visibility(
                visible: status == PuzzleStatus.complete,
                child: Container(
                  margin: const EdgeInsets.only(right: 24),
                  child: Image.asset(
                    'assets/images/mask.png',
                    width: widget.fontSize * 2,
                    height: widget.fontSize,
                  ),
                ),
              ),
            ),
            Text(
              '$moves steps',
              style: TextStyle(
                fontSize: widget.fontSize,
                fontFamily: 'HandWriting',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
