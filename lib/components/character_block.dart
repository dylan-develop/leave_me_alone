import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CharacterBlock extends StatefulWidget {
  const CharacterBlock({Key? key}) : super(key: key);

  @override
  State<CharacterBlock> createState() => _CharacterBlockState();
}

class _CharacterBlockState extends State<CharacterBlock> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  initState() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..addListener(() {
      if (controller.isCompleted) {
        controller.repeat();
      }
    });
    super.initState();
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  double shake(double value) => 2 * (0.5 - (0.5 - Curves.easeIn.transform(value)).abs());

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => controller.forward(),
      onExit: (event) => controller.stop(),
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(5 * shake(controller.value), 0),
            child: Image.asset(
              kIsWeb
                  ? 'images/character1.png'
                  : 'assets/images/character1.png',
            ),
          );
        }
      ),
    );
  }
}