part of 'puzzle_bloc.dart';

abstract class PuzzleEvent extends Equatable {
  const PuzzleEvent();

  @override
  List<Object> get props => [];
}

class TileTapped extends PuzzleEvent {
  final Tile tile;

  const TileTapped(this.tile);

  @override
  List<Object> get props => [tile];
}

class PuzzleReset extends PuzzleEvent {}
