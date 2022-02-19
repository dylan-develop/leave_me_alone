import 'package:equatable/equatable.dart';
import 'package:slide_puzzle/models/position.dart';

class Tile extends Equatable {
  final int value;
  final Position correctPosition;
  final Position currentPosition;
  final bool isWhitespace;

  const Tile({
    required this.value,
    required this.correctPosition,
    required this.currentPosition,
    this.isWhitespace = false,
  });

  @override
  List<Object> get props => [
        correctPosition,
        currentPosition,
        isWhitespace,
      ];
}
