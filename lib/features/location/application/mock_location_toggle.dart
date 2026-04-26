import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mock_location_toggle.g.dart';

class MockLocationState {
  const MockLocationState({
    this.enabled = false,
    this.latitude = 6.9271,
    this.longitude = 79.8612,
  });

  final bool enabled;
  final double latitude;
  final double longitude;

  MockLocationState copyWith({
    bool? enabled,
    double? latitude,
    double? longitude,
  }) {
    return MockLocationState(
      enabled: enabled ?? this.enabled,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}

@Riverpod(keepAlive: true)
class MockLocationToggle extends _$MockLocationToggle {
  @override
  MockLocationState build() => const MockLocationState();

  void toggle(bool enabled) {
    state = state.copyWith(enabled: enabled);
  }

  void setCoordinates({
    required double latitude,
    required double longitude,
  }) {
    state = state.copyWith(latitude: latitude, longitude: longitude);
  }
}
