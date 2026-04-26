// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_orchestrator_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(aiOrchestratorService)
const aiOrchestratorServiceProvider = AiOrchestratorServiceProvider._();

final class AiOrchestratorServiceProvider extends $FunctionalProvider<
    AiOrchestratorService,
    AiOrchestratorService,
    AiOrchestratorService> with $Provider<AiOrchestratorService> {
  const AiOrchestratorServiceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'aiOrchestratorServiceProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$aiOrchestratorServiceHash();

  @$internal
  @override
  $ProviderElement<AiOrchestratorService> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AiOrchestratorService create(Ref ref) {
    return aiOrchestratorService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AiOrchestratorService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AiOrchestratorService>(value),
    );
  }
}

String _$aiOrchestratorServiceHash() =>
    r'afd178ea917756dfd4e26d4230172711be413bd5';
