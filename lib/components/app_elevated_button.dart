import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppElevatedButton extends StatefulWidget {
  final double width;
  final double height;
  final String title;
  final String fontFamily;
  final double fontSize;
  final double? offset;
  final Function onTap;
  final Function(bool value)? onHover;
  final FocusNode? parentFocusNode;
  final PhysicalKeyboardKey? defaultPhysicalKey;
  final Function(KeyEvent event)? onKeyEventCallback;

  const AppElevatedButton({
    Key? key,
    required this.width,
    required this.height,
    required this.title,
    this.fontFamily = 'HandWriting',
    this.fontSize = 24,
    this.offset,
    required this.onTap,
    this.onHover,
    this.parentFocusNode,
    this.defaultPhysicalKey,
    this.onKeyEventCallback,
  }) : super(key: key);

  @override
  State<AppElevatedButton> createState() => _AppElevatedButtonState();
}

class _AppElevatedButtonState extends State<AppElevatedButton> {
  bool _onHover = false;

  @override
  Widget build(BuildContext context) {
    final _isDesktop = MediaQuery.of(context).size.width > 1024;

    return KeyboardListener(
      focusNode: widget.parentFocusNode ?? FocusNode(),
      onKeyEvent: (event) async {
        if (event.physicalKey == widget.defaultPhysicalKey) {
          setState(() {
            _onHover = true;
          });
          await Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted) {
              setState(() {
                _onHover = false;
                widget.onTap.call();
              });
            }
          });
        }
        widget.onKeyEventCallback?.call(event);
      },
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: widget.offset ?? (_isDesktop ? 8 : 4),
              top: widget.offset ?? (_isDesktop ? 8 : 4),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
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
              left: _onHover ? widget.offset ?? (_isDesktop ? 8 : 4) : 0,
              top: _onHover ? widget.offset ?? (_isDesktop ? 8 : 4) : 0,
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
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
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
        ),
      ),
    );
  }
}
