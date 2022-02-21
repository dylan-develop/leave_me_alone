import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CharacterBlock extends StatelessWidget {
  const CharacterBlock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      kIsWeb
          ? 'images/character1.png'
          : 'assets/images/character1.png',
    );
  }
}
