import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_me_alone/bloc/puzzle/puzzle_bloc.dart';
import 'package:leave_me_alone/models/puzzle.dart';
import 'package:lottie/lottie.dart';
import 'package:universal_platform/universal_platform.dart';

class AnimatedCharacterBlock extends StatefulWidget {
  final Duration initDelay;
  final bool isAnimated;
  final int imageIndex;

  const AnimatedCharacterBlock({
    Key? key,
    this.initDelay = Duration.zero,
    this.isAnimated = true,
    required this.imageIndex,
  }) : super(key: key);

  @override
  State<AnimatedCharacterBlock> createState() => _AnimatedCharacterBlockState();
}

class _AnimatedCharacterBlockState extends State<AnimatedCharacterBlock> {
  late Timer _timer;

  double _scale = 0;

  @override
  void initState() {
    _timer = Timer(widget.isAnimated ? widget.initDelay : Duration.zero, () {
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
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final puzzle = context.select((PuzzleBloc bloc) => bloc.state.puzzle);

    return AnimatedScale(
      scale: _scale,
      duration: Duration(milliseconds: widget.isAnimated ? 500 : 0),
      curve: Curves.elasticOut,
      child: !UniversalPlatform.isWeb || puzzle.getDifficulty() == PuzzleDifficulty.alpha
          ? Lottie.asset(
              'assets/lottie/char_${widget.imageIndex}.json',
            )
          : Image.asset(
              'assets/images/characters/char_${widget.imageIndex}.png',
            ),
    );
  }
}
