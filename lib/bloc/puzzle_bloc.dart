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
      final values = [for (int i = 0; i < pow(event.dimension, 2); i++) i]
        ..shuffle();
      emit(
        PuzzleState(
          puzzle: Puzzle([
            for (int i = 0; i < values.length; i++)
              Tile(
                value: i,
                currentPosition: Position(
                  values.indexOf(i) % event.dimension,
                  values.indexOf(i) ~/ event.dimension,
                ),
                isWhitespace: i == values.length - 1,
              ),
          ]),
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
      final values = [for (int i = 0; i < state.puzzle.tiles.length; i++) i]
        ..shuffle();
      emit(
        PuzzleState(
          puzzle: Puzzle([
            for (int i = 0; i < values.length; i++)
              Tile(
                value: i,
                currentPosition: Position(
                  values.indexOf(i) % sqrt(values.length).toInt(),
                  values.indexOf(i) ~/ sqrt(values.length).toInt(),
                ),
                isWhitespace: i == values.length - 1,
              ),
          ]),
          numberOfMoves: 0,
          status: PuzzleStatus.incomplete,
        ),
      );
    });
  }
}
