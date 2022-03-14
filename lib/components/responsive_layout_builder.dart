import 'package:flutter/material.dart';

enum ResponsiveLayoutSize {
  small,
  large,
}

abstract class ResponsiveLayoutBreakpoints {
  static const double small = 576;
  static const double large = 1200;
}

class ResponsiveLayoutBuilder extends StatelessWidget {
  final Function(BuildContext, Widget?) small;
  final Function(BuildContext, Widget?) large;

  final Function(ResponsiveLayoutSize size)? child;

  const ResponsiveLayoutBuilder({
    Key? key,
    required this.small,
    required this.large,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = MediaQuery.of(context).size.width;

          if (screenWidth >= ResponsiveLayoutBreakpoints.large) {
            return large(context, child?.call(ResponsiveLayoutSize.large));
          }

          return small(context, child?.call(ResponsiveLayoutSize.small));
        },
      ),
    );
  }
}
