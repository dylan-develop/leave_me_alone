import 'package:flutter/material.dart';

class AnimatedDistanceBlock extends StatefulWidget {
  final Duration initDelay;

  const AnimatedDistanceBlock({
    Key? key,
    this.initDelay = Duration.zero,
  }) : super(key: key);

  @override
  State<AnimatedDistanceBlock> createState() => _AnimatedDistanceBlockState();
}

class _AnimatedDistanceBlockState extends State<AnimatedDistanceBlock> {
  double _scale = 0;

  @override
  void initState() {
    Future.delayed(widget.initDelay, () {
      setState(() {
        _scale = 1;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedScale(
        scale: _scale,
        curve: Curves.bounceOut,
        duration: const Duration(milliseconds: 500),
        child: Image.asset(
          'assets/images/social_distance_block.png',
        ),
      ),
    );
  }
}
