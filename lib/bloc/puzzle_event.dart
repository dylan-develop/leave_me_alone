part of 'puzzle_bloc.dart';

abstract class PuzzleEvent extends Equatable {
  const PuzzleEvent();

  @override
  List<Object> get props => [];
}

class PuzzleInitialized extends PuzzleEvent {
  final int dimension;

  const PuzzleInitialized({required this.dimension});

  @override
  List<Object> get props => [dimension];
}

class TileTapped extends PuzzleEvent {
  final Tile tile;

  const TileTapped(this.tile);

  @override
  List<Object> get props => [tile];
}

class PuzzleReset extends PuzzleEvent {}
