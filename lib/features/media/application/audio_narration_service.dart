import 'package:just_audio/just_audio.dart';

class AudioNarrationService {
  AudioNarrationService(this._audioPlayer);

  final AudioPlayer _audioPlayer;

  Future<void> playNarration(String audioUrl) async {
    if (audioUrl.isEmpty) return;
    await _audioPlayer.setUrl(audioUrl);
    await _audioPlayer.play();
  }

  Future<void> dispose() => _audioPlayer.dispose();
}
