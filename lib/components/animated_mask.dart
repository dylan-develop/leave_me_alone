import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimatedMask extends StatefulWidget {
  final Duration initDelay;

  const AnimatedMask({
    Key? key,
    this.initDelay = Duration.zero,
  }) : super(key: key);

  @override
  State<AnimatedMask> createState() => _AnimatedMaskState();
}

class _AnimatedMaskState extends State<AnimatedMask>
    with TickerProviderStateMixin {
  double _scale = 0;

  late AnimationController _rotationController;
  final Tween<double> _rotationTween = Tween(begin: -0.025, end: 0.025);

  @override
  void initState() {
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    Future.delayed(widget.initDelay, () {
      if (mounted) {
        setState(() {
          _scale = 1;
        });
        _rotationController
            .forward()
            .whenComplete(() => _rotationController.repeat(reverse: true));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _scale,
      duration: const Duration(milliseconds: 500),
      child: RotationTransition(
        turns: _rotationTween.animate(_rotationController),
        child: Lottie.asset('assets/lottie/mask.json'),
      ),
    );
  }
}
