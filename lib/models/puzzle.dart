import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:slide_puzzle/models/position.dart';
import 'package:slide_puzzle/models/tile.dart';

class Puzzle extends Equatable {
  final List<Tile> tiles;

  const Puzzle(this.tiles);

  int getDimension() => sqrt(tiles.length).toInt();

  Tile getWhitespaceTile() =>
      tiles.singleWhere((tile) => tile.type == TileType.whitespace);

  bool isComplete() {
    for (Tile tile in tiles) {
      if (!isSocialDistanceAround(tile)) {
        return false;
      }
    }
    return true;
  }

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

  bool isSocialDistanceAround(Tile tile) {
    if (tile.type == TileType.character) {
      final top = tiles.where(
        (element) => tile.currentPosition.top() == element.currentPosition,
      );
      final bottom = tiles.where(
        (element) => tile.currentPosition.bottom() == element.currentPosition,
      );
      final left = tiles.where(
        (element) => tile.currentPosition.left() == element.currentPosition,
      );
      final right = tiles.where(
        (element) => tile.currentPosition.right() == element.currentPosition,
      );

      if (top.isNotEmpty &&
          top
              .where((tile) =>
                  tile.type == TileType.whitespace || tile.value % 2 != 0)
              .isEmpty) {
        return false;
      }
      if (bottom.isNotEmpty &&
          bottom
              .where((tile) =>
                  tile.type == TileType.whitespace || tile.value % 2 != 0)
              .isEmpty) {
        return false;
      }
      if (left.isNotEmpty &&
          left
              .where((tile) =>
                  tile.type == TileType.whitespace || tile.value % 2 != 0)
              .isEmpty) {
        return false;
      }
      if (right.isNotEmpty &&
          right
              .where((tile) =>
                  tile.type == TileType.whitespace || tile.value % 2 != 0)
              .isEmpty) {
        return false;
      }
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

  Puzzle sort() {
    final sortedTiles = [
      for (int i = 0; i < tiles.length; i++)
        tiles[i].copyWith(Position(
          i % getDimension(),
          i ~/ getDimension(),
        ))
    ];
    return Puzzle(sortedTiles);
  }

  @override
  List<Object> get props => [tiles];
}
