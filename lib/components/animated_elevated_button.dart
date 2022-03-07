import 'package:flutter/material.dart';

class AnimatedElevatedButton extends StatefulWidget {
  final Duration initDelay;
  final double width;
  final double height;
  final double offset;
  final String text;
  final String fontFamily;
  final double fontSize;
  final Function onPressed;

  const AnimatedElevatedButton({
    Key? key,
    this.initDelay = Duration.zero,
    required this.width,
    required this.height,
    required this.offset,
    required this.text,
    this.fontFamily = 'HandWriting',
    required this.fontSize,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<AnimatedElevatedButton> createState() => _AnimatedElevatedButtonState();
}

class _AnimatedElevatedButtonState extends State<AnimatedElevatedButton> {
  double _scale = 0;
  double _opacity = 0;

  bool _onHover = false;

  @override
  void initState() {
    Future.delayed(widget.initDelay, () {
      setState(() {
        _scale = 1;
      });
    }).whenComplete(() {
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          _opacity = 1;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: widget.offset,
            top: widget.offset,
            child: AnimatedOpacity(
              opacity: _opacity,
              duration: const Duration(milliseconds: 500),
              child: Container(
                width: widget.width,
                height: widget.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black,
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            left: _onHover ? widget.offset : 0,
            top: _onHover ? widget.offset : 0,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (event) {
                setState(() => _onHover = true);
              },
              onExit: (event) {
                setState(() => _onHover = false);
              },
              child: AnimatedScale(
                scale: _scale,
                duration: const Duration(milliseconds: 500),
                curve: Curves.bounceInOut,
                child: GestureDetector(
                  onTap: () {
                    widget.onPressed.call();
                  },
                  child: Container(
                    width: widget.width,
                    height: widget.height,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: widget.offset / 4,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        widget.text,
                        style: TextStyle(
                          fontFamily: widget.fontFamily,
                          fontSize: widget.fontSize,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
