import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:slide_puzzle/models/position.dart';
import 'package:slide_puzzle/models/puzzle.dart';
import 'package:slide_puzzle/models/tile.dart';

part 'puzzle_event.dart';
part 'puzzle_state.dart';

class PuzzleBloc extends Bloc<PuzzleEvent, PuzzleState> {
  PuzzleBloc() : super(const PuzzleState()) {
    on<PuzzleInitialized>((event, emit) {
      emit(
        PuzzleState(
          puzzle:  _generatePuzzle(event.dimension),
          numberOfMoves: 0,
          status: PuzzleStatus.incomplete,
        ),
      );
    });
    on<TileTapped>((event, emit) {
      if (state.status != PuzzleStatus.complete) {
        final tappedTile = event.tile;
        if (state.puzzle.isTileMovable(tappedTile)) {
          final mutablePuzzle = Puzzle([...state.puzzle.tiles]);
          final puzzle = mutablePuzzle.swapTiles(tappedTile);
          if (puzzle.isComplete()) {
            emit(
              state.copyWith(
                puzzle: puzzle,
                status: PuzzleStatus.complete,
                numberOfMoves: state.numberOfMoves + 1,
              ),
            );
          } else {
            emit(
              state.copyWith(
                puzzle: puzzle,
                status: PuzzleStatus.incomplete,
                numberOfMoves: state.numberOfMoves + 1,
              ),
            );
          }
        }
      }
    });
    on<PuzzleReset>((event, emit) {
      emit(
        PuzzleState(
          puzzle: _generatePuzzle(state.puzzle.getDimension()),
          numberOfMoves: 0,
          status: PuzzleStatus.incomplete,
        ),
      );
    });
  }

  Puzzle _generatePuzzle(int dimension) {
    final values = [for (int i = 0; i < pow(dimension, 2); i++) i]..shuffle();

    final puzzle = Puzzle([
      for (int i = 0; i < values.length; i++)
        Tile(
          value: i,
          currentPosition: Position(
            values.indexOf(i) % dimension,
            values.indexOf(i) ~/ dimension,
          ),
          type: i == values.length - 1
              ? TileType.whitespace
              : dimension % 2 != 0
                  ? i % 2 == 0
                      ? TileType.character
                      : TileType.socialDistance
                  : i ~/ dimension % 2 == 0
                      ? i % 2 == 0
                          ? TileType.character
                          : TileType.socialDistance
                      : i % 2 != 0
                          ? TileType.character
                          : TileType.socialDistance,
        ),
    ]);

    if (puzzle.isComplete()) {
      return _generatePuzzle(dimension);
    } else {
      return puzzle;
    }
  }
}
