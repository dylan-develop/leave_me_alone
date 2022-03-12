import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class AnimatedTyperText extends StatefulWidget {
  final String text;
  final String fontFamily;
  final double fontSize;
  final TextAlign textAlign;
  final Duration initDelay;
  final bool isAnimated;

  const AnimatedTyperText({
    Key? key,
    required this.text,
    this.fontFamily = 'HandWriting',
    required this.fontSize,
    this.textAlign = TextAlign.center,
    this.initDelay = Duration.zero,
    this.isAnimated = true,
  }) : super(key: key);

  @override
  State<AnimatedTyperText> createState() => _AnimatedTyperTextState();
}

class _AnimatedTyperTextState extends State<AnimatedTyperText> {
  List<AnimatedText> animatedTexts = [];

  @override
  void initState() {
    if (widget.isAnimated) {
      Future.delayed(widget.initDelay, () {
        setState(() {
          animatedTexts = [
            TyperAnimatedText(
              widget.text,
              textStyle: TextStyle(
                fontFamily: widget.fontFamily,
                fontSize: widget.fontSize,
              ),
              speed: const Duration(milliseconds: 50),
              textAlign: widget.textAlign,
            ),
          ];
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return animatedTexts.isEmpty || !widget.isAnimated
        ? Text(
            widget.text,
            style: TextStyle(
              fontFamily: widget.fontFamily,
              fontSize: widget.fontSize,
              color: !widget.isAnimated ? Colors.black : Colors.transparent,
            ),
            textAlign: widget.textAlign,
          )
        : AnimatedTextKit(
            animatedTexts: animatedTexts,
            isRepeatingAnimation: false,
            displayFullTextOnTap: widget.initDelay == Duration.zero,
          );
  }
}
