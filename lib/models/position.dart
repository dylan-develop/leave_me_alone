import 'package:equatable/equatable.dart';

class Position extends Equatable {
  final int x;
  final int y;

  const Position(this.x, this.y);

  Position top() => Position(x, y - 1);

  Position bottom() => Position(x, y + 1);

  Position left() => Position(x - 1, y);

  Position right() => Position(x + 1, y);

  @override
  List<Object> get props => [x, y];
}
