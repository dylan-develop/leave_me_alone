import 'package:flutter/material.dart';

class AnimatedTextButton extends StatefulWidget {
  final String text;
  final String fontFamily;
  final double fontSize;
  final Function onPressed;
  final Duration initDelay;

  const AnimatedTextButton({
    Key? key,
    required this.text,
    this.fontFamily = 'ThinkBig',
    this.fontSize = 32,
    required this.onPressed,
    this.initDelay = Duration.zero,
  }) : super(key: key);

  @override
  State<AnimatedTextButton> createState() => _AnimatedTextButtonState();
}

class _AnimatedTextButtonState extends State<AnimatedTextButton> {
  double _opacity = 0;

  @override
  void initState() {
    Future.delayed(widget.initDelay, () {
      if (mounted) {
        setState(() {
          _opacity = 1;
        });
      }
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
          child: Text(
            widget.text,
            style: TextStyle(
              fontSize: widget.fontSize,
              fontFamily: widget.fontFamily,
            ),
          ),
        ),
      ),
    );
  }
}
