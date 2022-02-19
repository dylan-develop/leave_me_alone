import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:slide_puzzle/models/tile.dart';

class Puzzle extends Equatable {
  final List<Tile> tiles;

  const Puzzle(this.tiles);

  int getDimension() => sqrt(tiles.length).toInt();

  @override
  List<Object> get props => [tiles];
}
