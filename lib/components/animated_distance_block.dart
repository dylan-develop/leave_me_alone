import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_me_alone/bloc/puzzle/puzzle_bloc.dart';

class AnimatedDistanceBlock extends StatefulWidget {
  final Duration initDelay;
  final bool isHints;

  const AnimatedDistanceBlock({
    Key? key,
    this.initDelay = Duration.zero,
    this.isHints = false,
  }) : super(key: key);

  @override
  State<AnimatedDistanceBlock> createState() => _AnimatedDistanceBlockState();
}

class _AnimatedDistanceBlockState extends State<AnimatedDistanceBlock> {
  double _scale = 0;
  bool _onHover = false;

  late Timer timer;

  @override
  void initState() {
    timer = Timer(widget.initDelay, () {
      if (mounted) {
        setState(() {
          _scale = 1;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final status = context.select((PuzzleBloc bloc) => bloc.state.status);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) {
        if (!widget.isHints) {
          setState(() {
            _onHover = true;
          });
        }
      },
      onExit: (event) {
        if (!widget.isHints) {
          setState(() {
            _onHover = false;
          });
        }
      },
      child: AnimatedScale(
        scale: _scale,
        curve: Curves.bounceOut,
        duration: const Duration(milliseconds: 500),
        child: Stack(
          children: [
            Image.asset(
              'assets/images/social_distance_block.png',
            ),
            Positioned.fill(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return FittedBox(
                    alignment: Alignment.center,
                    fit: BoxFit.fitWidth,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 250),
                      opacity: status == PuzzleStatus.incomplete && !_onHover
                          ? 1
                          : 0,
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: max(constraints.maxWidth * 0.2, 20),
                        ),
                        child: const Text(
                          'Leave me \nalone',
                          style: TextStyle(
                            fontFamily: 'ThinkBig',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned.fill(
              child: LayoutBuilder(
                builder: ((context, constraints) {
                  return FittedBox(
                    alignment: Alignment.center,
                    fit: BoxFit.fitWidth,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 250),
                      opacity:
                          status == PuzzleStatus.incomplete && _onHover ? 1 : 0,
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: max(constraints.maxWidth * 0.2, 20),
                        ),
                        child: const Text(
                          '1.5m',
                          style: TextStyle(
                            fontFamily: 'HandWriting',
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            Positioned.fill(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return FittedBox(
                    alignment: Alignment.center,
                    fit: BoxFit.fitWidth,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 250),
                      opacity: status == PuzzleStatus.complete ? 1 : 0,
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: max(constraints.maxWidth * 0.2, 20),
                        ),
                        child: const Text(
                          'Congratz',
                          style: TextStyle(
                            fontFamily: 'ThinkBig',
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
