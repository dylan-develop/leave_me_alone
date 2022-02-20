import 'package:flutter/material.dart';

class CustomElevatedButton extends StatefulWidget {
  final String title;
  final Function onPressed;

  const CustomElevatedButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (onEnter) {
        setState(() {
          isTapped = true;
        });
      },
      onExit: (onExit) {
        setState(() {
          isTapped = false;
        });
      },
      child: AnimatedSlide(
        duration: const Duration(microseconds: 200),
        offset: isTapped ? const Offset(0.03, 0.03) : const Offset(0, 0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: isTapped ? Colors.transparent: Colors.black,
                offset: isTapped ? const Offset(0, 0) : const Offset(3, 3),
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
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 5,
              ),
              child: Text(
                widget.title,
                style: TextStyle(
                  fontSize: 24,
                  color: isTapped ? Colors.grey[850] : Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
