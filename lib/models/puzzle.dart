import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:slide_puzzle/models/tile.dart';

class Puzzle extends Equatable {
  final List<Tile> tiles;

  const Puzzle(this.tiles);

  int getDimension() => sqrt(tiles.length).toInt();

  Tile getWhitespaceTile() => tiles.singleWhere((tile) => tile.isWhitespace);

  bool isTileMovable(Tile tile) {
    final whitespaceTile = getWhitespaceTile();
    if (tile == whitespaceTile) {
      return false;
    }

    final tilePosition = tile.currentPosition;
    final whitespacePosition = whitespaceTile.currentPosition;
    final deltaX = whitespacePosition.x - tilePosition.x;
    final deltaY = whitespacePosition.y - tilePosition.y;
    if (!((tilePosition.y == whitespacePosition.y && deltaX.abs() == 1) ||
        (tilePosition.x == whitespacePosition.x && deltaY.abs() == 1))) {
      return false;
    }

    return true;
  }

  Puzzle swapTiles(Tile tileToSwap) {
    final tileIndex = tiles.indexOf(tileToSwap);
    final tile = tiles[tileIndex];
    final whitespaceTile = getWhitespaceTile();
    final whitespaceTileIndex = tiles.indexOf(whitespaceTile);

    tiles[tileIndex] = tile.copyWith(whitespaceTile.currentPosition);
    tiles[whitespaceTileIndex] = whitespaceTile.copyWith(tile.currentPosition);

    return Puzzle(tiles);
  }

  @override
  List<Object> get props => [tiles];
}
