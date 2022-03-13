import 'dart:async';

import 'package:flutter/material.dart';

class AnimatedElevatedButton extends StatefulWidget {
  final Duration initDelay;
  final bool isAnimated;
  final double width;
  final double height;
  final double offset;
  final String text;
  final String fontFamily;
  final double fontSize;
  final Function onPressed;
  final Function(bool value)? onHover;

  const AnimatedElevatedButton({
    Key? key,
    this.initDelay = Duration.zero,
    this.isAnimated = true,
    required this.width,
    required this.height,
    required this.offset,
    required this.text,
    this.fontFamily = 'HandWriting',
    required this.fontSize,
    required this.onPressed,
    this.onHover,
  }) : super(key: key);

  @override
  State<AnimatedElevatedButton> createState() => _AnimatedElevatedButtonState();
}

class _AnimatedElevatedButtonState extends State<AnimatedElevatedButton> {
  double _scale = 0;
  double _opacity = 0;

  bool _onHover = false;
  bool _initAnimationCompleted = false;

  late Timer _scaleTimer;
  late Timer _opacityTimer;

  @override
  void initState() {
    if (!widget.isAnimated) {
      setState(() {
        _scale = 1;
        _opacity = 1;
        _initAnimationCompleted = true;
      });
    } else {
      _scaleTimer = Timer(widget.initDelay, () {
        if (mounted) {
          setState(() {
            _scale = 1;
          });
        }
      });
      _opacityTimer =
          Timer(widget.initDelay + const Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() {
            _opacity = 1;
            _initAnimationCompleted = true;
          });
        }
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    _scaleTimer.cancel();
    _opacityTimer.cancel();
    super.dispose();
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
              cursor: _initAnimationCompleted
                  ? SystemMouseCursors.click
                  : SystemMouseCursors.basic,
              onEnter: (event) {
                if (_initAnimationCompleted) {
                  widget.onHover?.call(true);
                  setState(() => _onHover = true);
                }
              },
              onExit: (event) {
                if (_initAnimationCompleted) {
                  widget.onHover?.call(false);
                  setState(() => _onHover = false);
                }
              },
              child: AnimatedScale(
                scale: _scale,
                duration: const Duration(milliseconds: 500),
                curve: Curves.bounceInOut,
                child: GestureDetector(
                  onTap: () async {
                    if (_initAnimationCompleted) {
                      widget.onPressed.call();
                    }
                  },
                  onTapDown: (event) {
                    if (_initAnimationCompleted) {
                      widget.onHover?.call(true);
                      setState(() => _onHover = true);
                    }
                  },
                  onTapUp: (event) {
                    if (_initAnimationCompleted) {
                      widget.onHover?.call(false);
                      setState(() => _onHover = false);
                    }
                  },
                  onTapCancel: () {
                    if (_initAnimationCompleted) {
                      widget.onHover?.call(false);
                      setState(() => _onHover = false);
                    }
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
