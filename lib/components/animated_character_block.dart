import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimatedCharacterBlock extends StatefulWidget {
  final int index;
  final Duration initDelay;
  final bool isAnimated;

  const AnimatedCharacterBlock({
    Key? key,
    required this.index,
    this.initDelay = Duration.zero,
    this.isAnimated = true,
  }) : super(key: key);

  @override
  State<AnimatedCharacterBlock> createState() => _AnimatedCharacterBlockState();
}

class _AnimatedCharacterBlockState extends State<AnimatedCharacterBlock> {
  double _scale = 0;

  bool _onHover = false;

  @override
  void initState() {
    Future.delayed(widget.isAnimated ? widget.initDelay : Duration.zero, () {
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
    return AnimatedScale(
      scale: _scale,
      duration: Duration(milliseconds: widget.isAnimated ? 1000 : 0),
      curve: Curves.elasticOut,
      child: kIsWeb
          ? Image.asset(
              'assets/images/characters/char_${widget.index}.png',
            )
          : MouseRegion(
              onEnter: (detail) {
                if (widget.isAnimated) {
                  setState(() {
                    _onHover = true;
                  });
                }
              },
              onExit: (detail) {
                if (widget.isAnimated) {
                  setState(() {
                    _onHover = false;
                  });
                }
              },
              child: Lottie.asset(
                'assets/lottie/char_${widget.index}_${_onHover ? 'hover' : 'default'}.json',
              ),
            ),
    );
  }
}
