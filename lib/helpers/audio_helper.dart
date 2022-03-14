import 'package:just_audio/just_audio.dart';

extension AudioPlayerExtension on AudioPlayer {
  Future<void> replay() async {
    await play();
    await seek(Duration.zero);
    await pause();
  }
} 