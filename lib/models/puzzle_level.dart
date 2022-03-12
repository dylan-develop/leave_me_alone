class PuzzleLevel {
  final String name;
  final String description;

  PuzzleLevel(this.name, this.description);
}

class PuzzleAlpha implements PuzzleLevel {
  @override
  String get name => 'ALPHA';
  @override
  String get description => 'Oh, you think you can handle this?';
}

class PuzzleBeta implements PuzzleLevel {
  @override
  String get name => 'BETA';
  @override
  String get description => 'Ha! Don\'t even think about winning.';
}

class PuzzleDelta implements PuzzleLevel {
  @override
  String get name => 'DELTA';
  @override
  String get description => 'Come on, this is way too easy.';
}
