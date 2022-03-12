import 'package:flutter/material.dart';

class ResponsiveBuilder extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;

  const ResponsiveBuilder({
    Key? key,
    required this.mobile,
    required this.desktop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;

        if (screenWidth < 1024) {
          return mobile;
        }
        if (screenWidth > 1024) {
          return desktop;
        }

        return mobile;
      },
    );
  }
}