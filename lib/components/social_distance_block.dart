import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_me_alone/bloc/puzzle_bloc.dart';

class SocialDistanceBlock extends StatefulWidget {
  final bool isHints;

  const SocialDistanceBlock({
    Key? key,
    this.isHints = false,
  }) : super(key: key);

  @override
  State<SocialDistanceBlock> createState() => _SocialDistanceBlockState();
}

class _SocialDistanceBlockState extends State<SocialDistanceBlock> {
  bool onHover = false;

  @override
  Widget build(BuildContext context) {
    final status = context.select((PuzzleBloc bloc) => bloc.state.status);

    return MouseRegion(
      onEnter: (event) {
        if (!widget.isHints) {
          setState(() {
            onHover = true;
          });
        }
      },
      onExit: (event) {
        if (!widget.isHints) {
          setState(() {
            onHover = false;
          });
        }
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            kIsWeb
                ? 'assets/images/social_distance_block.png'
                : 'assets/images/social_distance_block.gif',
          ),
          Positioned.fill(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return FittedBox(
                  alignment: Alignment.center,
                  fit: BoxFit.fitWidth,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: status == PuzzleStatus.incomplete && !onHover ? 1 : 0,
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
                    duration: const Duration(milliseconds: 500),
                    opacity: status == PuzzleStatus.incomplete && onHover ? 1 : 0,
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
                    duration: const Duration(milliseconds: 500),
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
    );
  }
}
