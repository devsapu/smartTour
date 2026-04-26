// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_narration_service_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(audioNarrationService)
const audioNarrationServiceProvider = AudioNarrationServiceProvider._();

final class AudioNarrationServiceProvider extends $FunctionalProvider<
    AudioNarrationService,
    AudioNarrationService,
    AudioNarrationService> with $Provider<AudioNarrationService> {
  const AudioNarrationServiceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'audioNarrationServiceProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$audioNarrationServiceHash();

  @$internal
  @override
  $ProviderElement<AudioNarrationService> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AudioNarrationService create(Ref ref) {
    return audioNarrationService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AudioNarrationService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AudioNarrationService>(value),
    );
  }
}

String _$audioNarrationServiceHash() =>
    r'0b688473040842075be7dbd6b6c9eb7ade40cd50';
