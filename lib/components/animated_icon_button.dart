import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnimatedIconButton extends StatefulWidget {
  final String imageUrl;
  final Function onPressed;
  final Duration initDelay;

  const AnimatedIconButton({
    Key? key,
    required this.imageUrl,
    required this.onPressed,
    this.initDelay = Duration.zero,
  }) : super(key: key);

  @override
  State<AnimatedIconButton> createState() => _AnimatedIconButtonState();
}

class _AnimatedIconButtonState extends State<AnimatedIconButton> {
  double _opacity = 0;

  @override
  void initState() {
    Future.delayed(widget.initDelay, () {
      setState(() {
        _opacity = 1;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(milliseconds: 500),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            widget.onPressed.call();
          },
          child: SvgPicture.asset(
            widget.imageUrl,
            width: 24,
            alignment: Alignment.centerLeft,
          ),
        ),
      ),
    );
  }
}
