import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatefulWidget {
  final String title;
  final Function onPressed;
  final double fontSize;
  final String fontFamily;
  final EdgeInsets? padding;

  const CustomElevatedButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.fontSize = 24,
    this.fontFamily = 'HandWriting',
    this.padding,
  }) : super(key: key);

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  bool onHover = false;
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (onEnter) {
        onHover = true;
        setState(() {
          isTapped = true;
        });
      },
      onExit: (onExit) {
        onHover = false;
        setState(() {
          isTapped = false;
        });
      },
      child: GestureDetector(
        onTapDown: (event) {
          setState(() {
            isTapped = true;
          });
          widget.onPressed.call();
        },
        onTapUp: (event) {
          setState(() {
            if (!kIsWeb) {
              isTapped = false;
            }
          });
        },
        onTapCancel: () {
          setState(() {
            if (!kIsWeb) {
              isTapped = false;
            }
          });
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            final deltaX = 4 / constraints.maxWidth;
            final deltaY = 4 / constraints.maxHeight;

            return AnimatedSlide(
              duration: const Duration(milliseconds: 200),
              offset: isTapped ? Offset(deltaX, deltaY) : const Offset(0, 0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: isTapped ? Colors.transparent : Colors.black,
                      offset:
                          isTapped ? const Offset(0, 0) : const Offset(4, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: widget.padding ??
                      EdgeInsets.symmetric(
                        horizontal:
                            20 * MediaQuery.of(context).size.width / 768,
                        vertical: 5 * MediaQuery.of(context).size.width / 768,
                      ),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: widget.fontSize,
                      color: isTapped ? Colors.grey[850] : Colors.black,
                      fontFamily: widget.fontFamily,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
