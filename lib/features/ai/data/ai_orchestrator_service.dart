import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../notebook/domain/smart_travel_notebook.dart';

part 'ai_orchestrator_service.g.dart';

class AiOrchestratorService {
  AiOrchestratorService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  Future<List<TimelinePoi>> generatePlan({required Trip trip}) async {
    // This is intentionally mock-first for MVP classrooms.
    // Replace with Gemini/OpenAI endpoint using secure env injection.
    final fakeResponse = jsonEncode({
      'timeline': List.generate(
        7,
        (day) => {
          'id': 'day-${day + 1}',
          'title': 'Day ${day + 1} - ${trip.destination} Highlight',
          'latitude': 6.9271 + (day * 0.0012),
          'longitude': 79.8612 + (day * 0.0011),
          'audioUrl': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
          'whySuggested':
              'Based on your preference for ${trip.preferences.firstOrNull ?? "local culture"}.',
          'historicalContext':
              'This location reflects the local story and social history of ${trip.destination}.',
          'status': 'pending',
          'isIndoor': day.isEven,
        },
      ),
    });

    final decoded = jsonDecode(fakeResponse) as Map<String, dynamic>;
    final timeline = (decoded['timeline'] as List<dynamic>)
        .map((e) => TimelinePoi.fromJson(e as Map<String, dynamic>))
        .toList();
    return timeline;
  }

  Future<List<TimelinePoi>> replanForWeather({
    required List<TimelinePoi> timeline,
    required String weather,
    required List<String> preferences,
  }) async {
    if (weather.toLowerCase() != 'rainy') return timeline;

    return [
      for (final poi in timeline)
        if (!poi.isIndoor)
          poi.copyWith(
            isIndoor: true,
            whySuggested:
                'Rain expected. Swapped to an indoor stop aligned to ${preferences.firstOrNull ?? "your preferences"}.',
          )
        else
          poi,
    ];
  }

  Future<void> dispose() async {
    _client.close();
  }
}

@Riverpod(keepAlive: true)
AiOrchestratorService aiOrchestratorService(Ref ref) {
  final service = AiOrchestratorService();
  ref.onDispose(service.dispose);
  return service;
}
