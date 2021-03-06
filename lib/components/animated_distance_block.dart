import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_me_alone/bloc/puzzle/puzzle_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:universal_platform/universal_platform.dart';

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

  @override
  void initState() {
    Future.delayed(widget.initDelay, () {
      if (mounted) {
        setState(() {
          _scale = 1;
        });
      }
    });
    super.initState();
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
            UniversalPlatform.isWeb
                ? Image.asset(
                    'assets/images/block.png',
                  )
                : Lottie.asset(
                    'assets/lottie/block.json',
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
