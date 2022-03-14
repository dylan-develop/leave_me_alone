import 'dart:async';

import 'package:flutter/material.dart';
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
      duration: Duration(milliseconds: widget.isAnimated ? 500 : 0),
      curve: Curves.elasticOut,
      child: UniversalPlatform.isWeb
          ? Image.asset(
              'assets/images/characters/char_${widget.imageIndex}.png',
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
                'assets/lottie/char_${widget.imageIndex}_${_onHover ? 'hover' : 'default'}.json',
              ),
            ),
    );
  }
}
