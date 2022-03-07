import 'package:flutter/material.dart';

class AnimatedCharacterBlock extends StatefulWidget {
  final String imageUrl;
  final Duration initDelay;
  final bool isAnimated;

  const AnimatedCharacterBlock({
    Key? key,
    required this.imageUrl,
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
        widget.imageUrl,
      ),
    );
  }
}
