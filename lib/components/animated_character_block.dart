import 'package:flutter/material.dart';

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

  @override
  void initState() {
    Future.delayed(widget.isAnimated ? widget.initDelay : Duration.zero, () {
      setState(() {
        _scale = 1;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _scale,
      duration: Duration(milliseconds: widget.isAnimated ? 1000 : 0),
      curve: Curves.elasticOut,
      child: Image.asset(
        'assets/images/characters/char_${widget.index}.png',
      ),
    );
  }
}
