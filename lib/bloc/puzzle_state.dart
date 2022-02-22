part of 'puzzle_bloc.dart';

enum PuzzleStatus { incomplete, complete }

class PuzzleState extends Equatable {
  final Puzzle puzzle;
  final int numberOfMoves;
  final PuzzleStatus status;

  const PuzzleState({
    this.puzzle = const Puzzle([]),
    this.numberOfMoves = 0,
    this.status = PuzzleStatus.incomplete,
  });

  PuzzleState copyWith({
    Puzzle? puzzle,
    int? numberOfMoves,
    PuzzleStatus? status,
  }) {
    return PuzzleState(
      puzzle: puzzle ?? this.puzzle,
      numberOfMoves: numberOfMoves ?? this.numberOfMoves,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [puzzle];
}
