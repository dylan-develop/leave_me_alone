import 'package:flutter/material.dart';
import 'package:slide_puzzle/components/puzzle_board.dart';

import '../components/animated_puzzle_board.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          AnimatedPuzzleBoard(
            key: UniqueKey(),
          ),
          Expanded(
            child: PuzzleBoard(
              key: UniqueKey(),
            ),
          ),
        ],
      ),
    );
  }
}
