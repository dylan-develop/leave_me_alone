import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatefulWidget {
  final String title;
  final Function onPressed;
  final double fontSize;
  final String fontFamily;
  final EdgeInsets? padding;
  final Function(bool isHover)? onHoverCallback;

  const CustomElevatedButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.fontSize = 24,
    this.fontFamily = 'HandWriting',
    this.padding,
    this.onHoverCallback,
  }) : super(key: key);

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  final GlobalKey _buttonKey = GlobalKey();
  double offset = 4;
  double deltaX = 0;
  double deltaY = 0;

  bool onHover = false;
  bool isTapped = false;

  @override
  void didChangeDependencies() {
    offset = MediaQuery.of(context).size.width > 1024 ? 8 : 4;
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      final buttonRenderBox = _buttonKey.currentContext?.findRenderObject() as RenderBox?;
      deltaX = offset / (buttonRenderBox?.size.width ?? 1);
      deltaY = offset / (buttonRenderBox?.size.height ?? 1);
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (onEnter) {
        onHover = true;
        widget.onHoverCallback?.call(true);
        setState(() {
          isTapped = true;
        });
      },
      onExit: (onExit) {
        onHover = false;
        widget.onHoverCallback?.call(false);
        setState(() {
          isTapped = false;
        });
      },
      child: GestureDetector(
        onTap: () {
          widget.onPressed.call();
        },
        onTapDown: (event) {
          setState(() {
            isTapped = true;
          });
          widget.onHoverCallback?.call(true);
        },
        onTapUp: (event) {
          setState(() {
            if (!kIsWeb) {
              isTapped = false;
            }
          });
          widget.onHoverCallback?.call(false);
        },
        onTapCancel: () {
          setState(() {
            if (!kIsWeb) {
              isTapped = false;
            }
          });
          widget.onHoverCallback?.call(false);
        },
        child: AnimatedSlide(
          duration: const Duration(milliseconds: 200),
          offset: isTapped ? Offset(deltaX, deltaY) : const Offset(0, 0),
          child: Container(
            key: _buttonKey,
            decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.black,
                  width: MediaQuery.of(context).size.width > 1024 ? 2 : 1),
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: isTapped ? Colors.transparent : Colors.black,
                  offset:
                      isTapped ? const Offset(0, 0) : Offset(offset, offset),
                ),
              ],
            ),
            child: Padding(
              padding: widget.padding ??
                  EdgeInsets.symmetric(
                    horizontal:
                        max(32 * MediaQuery.of(context).size.width / 768, 24),
                  ),
              child: Text(
                widget.title,
                style: TextStyle(
                  fontSize: widget.fontSize,
                  height: 1.5,
                  color: isTapped ? Colors.grey[850] : Colors.black,
                  fontFamily: widget.fontFamily,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
