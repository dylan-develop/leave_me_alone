class PuzzleLevel {
  final String name;
  final String description;
  final String audioPath;

  PuzzleLevel(this.name, this.description, this.audioPath);
}

class PuzzleAlpha implements PuzzleLevel {
  @override
  String get name => 'ALPHA';
  @override
  String get description => 'Oh, you think you can handle this?';
  @override
  String get audioPath => 'assets/audio/sneeze.wav';
}

class PuzzleBeta implements PuzzleLevel {
  @override
  String get name => 'BETA';
  @override
  String get description => 'Ha! Don\'t even think about winning.';
  @override
  String get audioPath => 'assets/audio/female_cough.wav';
}

class PuzzleDelta implements PuzzleLevel {
  @override
  String get name => 'DELTA';
  @override
  String get description => 'Come on, this is way too easy.';
  @override
  String get audioPath => 'assets/audio/male_cough.wav';
}
