import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:slide_puzzle/components/responsive_layout_builder.dart';

class SocialDistanceBlock extends StatelessWidget {
  final double? fontSize;

  const SocialDistanceBlock({
    Key? key,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          kIsWeb
              ? 'images/social_distance_block.png'
              : 'assets/images/social_distance_block.png',
        ),
        Align(
          alignment: Alignment.center,
          child: ResponsiveLayoutBuilder(
            mobile: Text(
              '1.5m',
              style: TextStyle(
                fontFamily: 'HandWriting',
                fontSize: fontSize ?? 24,
              ),
            ),
            desktop: Text(
              '1.5m',
              style: TextStyle(
                fontFamily: 'HandWriting',
                fontSize: fontSize ?? 36,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
