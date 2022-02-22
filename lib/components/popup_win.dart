import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:slide_puzzle/components/popup_container.dart';
import 'package:slide_puzzle/components/responsive_layout_builder.dart';

class WinPopup extends StatelessWidget {
  const WinPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupContainer(
      child: ResponsiveLayoutBuilder(
        mobile: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 32),
                child: const Text(
                  'CONGRATZ',
                  style: TextStyle(
                    fontSize: 36,
                    fontFamily: 'ThinkBig',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 32),
                child: const Text(
                  'Here\'s a mask for you :)',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'HandWriting',
                  ),
                ),
              ),
              Image.asset(
                kIsWeb ? 'images/mask.png' : 'assets/images/mask.png',
              ),
            ],
          ),
        ),
        desktop: Container(
          padding: const EdgeInsets.symmetric(horizontal: 55),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 32),
                child: const Text(
                  'CONGRATZ',
                  style: TextStyle(
                    fontSize: 48,
                    fontFamily: 'ThinkBig',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 32),
                child: const Text(
                  'Here\'s a mask for you :)',
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: 'HandWriting',
                  ),
                ),
              ),
              Image.asset(
                kIsWeb ? 'images/mask.png' : 'assets/images/mask.png',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
