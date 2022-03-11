part of 'puzzle_bloc.dart';

enum PuzzleStatus { incomplete, complete }

enum PuzzleStage { initialized, reset, started}

class PuzzleState extends Equatable {
  final Puzzle puzzle;
  final int numberOfMoves;
  final PuzzleStatus status;
  final PuzzleStage stage;

  const PuzzleState({
    this.puzzle = const Puzzle([]),
    this.numberOfMoves = 0,
    this.status = PuzzleStatus.incomplete,
    this.stage = PuzzleStage.initialized,
  });

  PuzzleState copyWith({
    Puzzle? puzzle,
    int? numberOfMoves,
    PuzzleStatus? status,
    PuzzleStage? stage,
  }) {
    return PuzzleState(
      puzzle: puzzle ?? this.puzzle,
      numberOfMoves: numberOfMoves ?? this.numberOfMoves,
      status: status ?? this.status,
      stage: stage ?? this.stage,
    );
  }

  @override
  List<Object> get props => [puzzle];
}
