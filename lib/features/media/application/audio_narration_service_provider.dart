import 'package:just_audio/just_audio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'audio_narration_service.dart';

part 'audio_narration_service_provider.g.dart';

@Riverpod(keepAlive: true)
AudioNarrationService audioNarrationService(Ref ref) {
  final service = AudioNarrationService(AudioPlayer());
  ref.onDispose(service.dispose);
  return service;
}
