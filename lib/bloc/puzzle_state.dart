part of 'puzzle_bloc.dart';

// abstract class PuzzleState extends Equatable {
//   const PuzzleState();

//   @override
//   List<Object> get props => [];
// }

// class PuzzleInitial extends PuzzleState {}

class PuzzleState extends Equatable {
  final Puzzle puzzle;
  final int numberOfMoves;

  const PuzzleState({
    this.puzzle = const Puzzle([]),
    this.numberOfMoves = 0,
  });

  PuzzleState copyWith({
    Puzzle? puzzle,
    int? numberOfMoves,
  }) {
    return PuzzleState(
      puzzle: puzzle ?? this.puzzle,
      numberOfMoves: numberOfMoves ?? this.numberOfMoves,
    );
  }

  @override
  List<Object> get props => [puzzle];
}
