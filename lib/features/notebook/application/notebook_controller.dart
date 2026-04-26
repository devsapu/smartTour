import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../ai/data/ai_orchestrator_service.dart';
import '../../location/application/mock_location_toggle.dart';
import '../domain/smart_travel_notebook.dart';

part 'notebook_controller.g.dart';

@Riverpod(keepAlive: true)
class NotebookController extends _$NotebookController {
  @override
  SmartTravelNotebook build() => SmartTravelNotebook.initial();

  void loadItinerary(List<TimelinePoi> timeline) {
    state = state.copyWith(timeline: timeline);
  }

  void updateLiveContext(LiveContext context) {
    state = state.copyWith(liveContext: context);
  }

  void markPoiStatus(String poiId, PoiStatus status) {
    final updated = [
      for (final poi in state.timeline)
        if (poi.id == poiId) poi.copyWith(status: status) else poi,
    ];
    state = state.copyWith(timeline: updated);
  }

  void addMemory(String behavior) {
    if (state.memory.contains(behavior)) return;
    state = state.copyWith(memory: [...state.memory, behavior]);
  }

  Future<void> generateInitialPlan() async {
    final itinerary = await ref.read(aiOrchestratorServiceProvider).generatePlan(
          trip: state.trip,
        );
    state = state.copyWith(timeline: itinerary);
  }

  Future<void> replanForWeather(String weather) async {
    final replanned = await ref.read(aiOrchestratorServiceProvider).replanForWeather(
          timeline: state.timeline,
          weather: weather,
          preferences: state.trip.preferences,
        );
    state = state.copyWith(
      timeline: replanned,
      liveContext: state.liveContext.copyWith(weather: weather),
    );
  }

  void applyLocationUpdate({
    required double latitude,
    required double longitude,
    String? weather,
  }) {
    final mock = ref.read(mockLocationToggleProvider);
    if (!mock.enabled) {
      updateLiveContext(
        state.liveContext.copyWith(
          latitude: latitude,
          longitude: longitude,
          weather: weather ?? state.liveContext.weather,
        ),
      );
      return;
    }

    updateLiveContext(
      state.liveContext.copyWith(
        latitude: mock.latitude,
        longitude: mock.longitude,
        weather: weather ?? state.liveContext.weather,
      ),
    );
  }
}
