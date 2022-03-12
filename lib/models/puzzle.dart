import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';
import 'package:leave_me_alone/models/position.dart';
import 'package:leave_me_alone/models/tile.dart';
import 'package:collection/collection.dart';

enum PuzzleDifficulty { alpha, beta, delta }
class Puzzle extends Equatable {
  final List<Tile> tiles;

  const Puzzle(this.tiles);

  int getDimension() => sqrt(tiles.length).toInt();

  PuzzleDifficulty getDifficulty() {
    switch (getDimension()) {
      case 4:
        return PuzzleDifficulty.beta;
      case 5:
        return PuzzleDifficulty.delta;
      default:
        return PuzzleDifficulty.alpha;
    }
  }

  PuzzleDifficulty getNextDifficulty() {
    final index = PuzzleDifficulty.values.indexOf(getDifficulty());
    if (index >= PuzzleDifficulty.values.length - 1) {
      return PuzzleDifficulty.values[index];
    } else if (index <= -1) {
      return PuzzleDifficulty.values[0];
    } else {
      return PuzzleDifficulty.values[index + 1];
    }
  }

  bool hasNextDifficulty() {
    if (getDifficulty() != PuzzleDifficulty.values.last) {
      return true;
    } 
    return false;
  }

  Tile getWhitespaceTile() {
    return tiles.singleWhere((tile) => tile.type == TileType.whitespace);
  }

  Tile? getTileRelativeToWhitespaceTile(Offset relativeOffset) {
    final whitespace = getWhitespaceTile();
    return tiles.singleWhereOrNull(
      (tile) {
        return tile.currentPosition.x ==
                whitespace.currentPosition.x + relativeOffset.dx &&
            tile.currentPosition.y ==
                whitespace.currentPosition.y + relativeOffset.dy;
      },
    );
  }

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
                  tile.type == TileType.whitespace ||
                  tile.type == TileType.socialDistance)
              .isEmpty) {
        return false;
      }
      if (bottom.isNotEmpty &&
          bottom
              .where((tile) =>
                  tile.type == TileType.whitespace ||
                  tile.type == TileType.socialDistance)
              .isEmpty) {
        return false;
      }
      if (left.isNotEmpty &&
          left
              .where((tile) =>
                  tile.type == TileType.whitespace ||
                  tile.type == TileType.socialDistance)
              .isEmpty) {
        return false;
      }
      if (right.isNotEmpty &&
          right
              .where((tile) =>
                  tile.type == TileType.whitespace ||
                  tile.type == TileType.socialDistance)
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
