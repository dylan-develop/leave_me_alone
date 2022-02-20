import 'package:flutter/material.dart';

class CustomElevatedButton extends StatefulWidget {
  final String title;
  final Function onPressed;
  final double fontSize;

  const CustomElevatedButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.fontSize = 24,
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
      child: AnimatedSlide(
        duration: const Duration(microseconds: 200),
        offset: isTapped ? const Offset(0.04, 0.04) : const Offset(0, 0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: isTapped ? Colors.transparent : Colors.black,
                offset: isTapped ? const Offset(0, 0) : const Offset(4, 4),
              ),
            ],
          ),
          child: MaterialButton(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: () {
              widget.onPressed.call();
              setState(() {
                isTapped = true;
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20 * MediaQuery.of(context).size.width / 768,
                vertical: 5 * MediaQuery.of(context).size.width / 768,
              ),
              child: Text(
                widget.title,
                style: TextStyle(
                  fontSize: widget.fontSize,
                  color: isTapped ? Colors.grey[850] : Colors.black,
                  fontFamily: 'HandWriting',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
