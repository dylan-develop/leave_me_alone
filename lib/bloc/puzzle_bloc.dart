import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:slide_puzzle/models/position.dart';
import 'package:slide_puzzle/models/puzzle.dart';
import 'package:slide_puzzle/models/tile.dart';

part 'puzzle_event.dart';
part 'puzzle_state.dart';

class PuzzleBloc extends Bloc<PuzzleEvent, PuzzleState> {
  PuzzleBloc() : super(const PuzzleState()) {
    on<TileTapped>((event, emit) {
      final tappedTile = event.tile;
      if (state.puzzle.isTileMovable(tappedTile)) {
        final mutablePuzzle = Puzzle([...state.puzzle.tiles]);
        final puzzle = mutablePuzzle.swapTiles(tappedTile);
        emit(
          state.copyWith(
            puzzle: puzzle,
            numberOfMoves: state.numberOfMoves + 1,
          ),
        );
      }
      emit(state);
    });
    on<PuzzleReset>((event, emit) {
      final values = [for (int i = 0; i < 9; i++) i]
        ..shuffle();
      emit(PuzzleState(
          puzzle: Puzzle([
        for (int i = 0; i < values.length; i++)
          Tile(
            value: i,
            currentPosition:
                Position(values.indexOf(i) % 3, values.indexOf(i) ~/ 3),
            isWhitespace: i == 8,
          )
      ])));
    });
  }
}
