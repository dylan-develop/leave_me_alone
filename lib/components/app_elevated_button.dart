import 'package:flutter/material.dart';

class AppElevatedButton extends StatefulWidget {
  final double width;
  final double height;
  final String title;
  final String fontFamily;
  final double fontSize;
  final Function onTap;
  final Function(bool value)? onHover;

  const AppElevatedButton({
    Key? key,
    required this.width,
    required this.height,
    required this.title,
    this.fontFamily = 'HandWriting',
    this.fontSize = 24,
    required this.onTap,
    this.onHover,
  }) : super(key: key);

  @override
  State<AppElevatedButton> createState() => _AppElevatedButtonState();
}

class _AppElevatedButtonState extends State<AppElevatedButton> {
  bool _onHover = false;

  @override
  Widget build(BuildContext context) {
    final _isDesktop = MediaQuery.of(context).size.width > 1024;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: _isDesktop ? 8 : 4,
          top: _isDesktop ? 8 : 4,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
            ),
            width: widget.width,
            height: widget.height,
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 200),
          left: _onHover
              ? _isDesktop
                  ? 8
                  : 4
              : 0,
          top: _onHover
              ? _isDesktop
                  ? 8
                  : 4
              : 0,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (event) {
              setState(() {
                _onHover = true;
              });
              widget.onHover?.call(true);
            },
            onExit: (event) {
              setState(() {
                _onHover = false;
              });
              widget.onHover?.call(false);
            },
            child: GestureDetector(
              onTap: () {
                widget.onTap.call();
              },
              onTapDown: (event) {
                setState(() {
                  _onHover = true;
                });
                widget.onHover?.call(true);
              },
              onTapUp: (event) {
                setState(() {
                  _onHover = false;
                });
                widget.onHover?.call(false);
              },
              onTapCancel: () {
                setState(() {
                  _onHover = false;
                });
                widget.onHover?.call(false);
              },
              child: Container(
                width: widget.width,
                height: widget.height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.black,
                    width: _isDesktop ? 2 : 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: widget.fontSize,
                      fontFamily: widget.fontFamily,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
