import 'dart:ui';

import 'package:flutter/material.dart';

Future<T?> showSlideDialog<T>({
  required BuildContext context,
  required Widget child,
  bool barrierDismissible = true,
  String barrierLabel = '',
  Offset? beginOffset,
  Curve curve = Curves.easeInOutBack,
}) =>
    showGeneralDialog<T>(
      transitionBuilder: (context, animation, secondaryAnimation, widget) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: beginOffset ?? const Offset(0.0, 1.0),
              end: Offset.zero,
            ).animate(curvedAnimation),
            child: FadeTransition(
              opacity: curvedAnimation,
              child: widget,
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 500),
      barrierDismissible: barrierDismissible,
      barrierLabel: barrierLabel,
      barrierColor: Colors.white.withOpacity(0.7),
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) => child,
    );
