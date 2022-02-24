import 'package:equatable/equatable.dart';
import 'package:leave_me_alone/models/position.dart';

enum TileType { character, socialDistance, whitespace }

class Tile extends Equatable {
  final int value;
  final Position currentPosition;
  final TileType type;

  const Tile({
    required this.value,
    required this.currentPosition,
    required this.type,
  });

  Tile copyWith(Position currentPosition) {
    return Tile(
      value: value,
      currentPosition: currentPosition,
      type: type,
    );
  }

  @override
  List<Object> get props => [
        value,
        currentPosition,
        type,
      ];
}
