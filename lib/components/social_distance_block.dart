import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:slide_puzzle/components/responsive_layout_builder.dart';

class SocialDistanceBlock extends StatefulWidget {
  final double? fontSize;

  const SocialDistanceBlock({
    Key? key,
    this.fontSize,
  }) : super(key: key);

  @override
  State<SocialDistanceBlock> createState() => _SocialDistanceBlockState();
}

class _SocialDistanceBlockState extends State<SocialDistanceBlock> {
  bool onHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          onHover = true;
        });
      },
      onExit: (event) {
        setState(() {
          onHover = false;
        });
      },
      child: Stack(
        children: [
          Image.asset(
            kIsWeb
                ? 'images/social_distance_block.png'
                : 'assets/images/social_distance_block.png',
          ),
          Align(
            alignment: Alignment.center,
            child: ResponsiveLayoutBuilder(
              mobile: AnimatedCrossFade(
                crossFadeState: !onHover ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                sizeCurve: Curves.decelerate,
                duration: const Duration(milliseconds: 500),
                firstChild: Text(
                  'Leave me alone',
                  style: TextStyle(
                    fontFamily: 'ThinkBig',
                    fontSize: widget.fontSize == null ? 10 : widget.fontSize! - 14,
                  ),
                ),
                secondChild: Text(
                  '1.5m',
                  style: TextStyle(
                    fontFamily: 'HandWriting',
                    fontSize: widget.fontSize ?? 24,
                  ),
                ), 
              ),
              desktop: AnimatedCrossFade(
                crossFadeState: !onHover ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                sizeCurve: Curves.decelerate,
                duration: const Duration(milliseconds: 500),
                firstChild: Text(
                  'Leave me alone',
                  style: TextStyle(
                    fontFamily: 'ThinkBig',
                    fontSize: widget.fontSize == null ? 20 : widget.fontSize! - 14,
                  ),
                ),
                secondChild: Text(
                  '1.5m',
                  style: TextStyle(
                    fontFamily: 'HandWriting',
                    fontSize: widget.fontSize ?? 32,
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
