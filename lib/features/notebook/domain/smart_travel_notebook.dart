import 'package:json_annotation/json_annotation.dart';

part 'smart_travel_notebook.g.dart';

enum PoiStatus { pending, arrived, skipped }

@JsonSerializable()
class Trip {
  const Trip({
    required this.destination,
    required this.budget,
    required this.preferences,
  });

  final String destination;
  final double budget;
  final List<String> preferences;

  factory Trip.fromJson(Map<String, dynamic> json) => _$TripFromJson(json);
  Map<String, dynamic> toJson() => _$TripToJson(this);
}

@JsonSerializable()
class TimelinePoi {
  const TimelinePoi({
    required this.id,
    required this.title,
    required this.latitude,
    required this.longitude,
    required this.audioUrl,
    required this.whySuggested,
    this.historicalContext = '',
    this.status = PoiStatus.pending,
    this.isIndoor = false,
  });

  final String id;
  final String title;
  final double latitude;
  final double longitude;
  final String audioUrl;
  final String whySuggested;
  final String historicalContext;
  final PoiStatus status;
  final bool isIndoor;

  TimelinePoi copyWith({
    PoiStatus? status,
    String? whySuggested,
    bool? isIndoor,
  }) {
    return TimelinePoi(
      id: id,
      title: title,
      latitude: latitude,
      longitude: longitude,
      audioUrl: audioUrl,
      whySuggested: whySuggested ?? this.whySuggested,
      historicalContext: historicalContext,
      status: status ?? this.status,
      isIndoor: isIndoor ?? this.isIndoor,
    );
  }

  factory TimelinePoi.fromJson(Map<String, dynamic> json) =>
      _$TimelinePoiFromJson(json);
  Map<String, dynamic> toJson() => _$TimelinePoiToJson(this);
}

@JsonSerializable()
class LiveContext {
  LiveContext({
    this.latitude = 0,
    this.longitude = 0,
    this.weather = 'Clear',
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  final double latitude;
  final double longitude;
  final String weather;
  final DateTime timestamp;

  LiveContext copyWith({
    double? latitude,
    double? longitude,
    String? weather,
    DateTime? timestamp,
  }) {
    return LiveContext(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      weather: weather ?? this.weather,
      timestamp: timestamp ?? DateTime.now(),
    );
  }

  factory LiveContext.fromJson(Map<String, dynamic> json) =>
      _$LiveContextFromJson(json);
  Map<String, dynamic> toJson() => _$LiveContextToJson(this);
}

@JsonSerializable()
class SmartTravelNotebook {
  const SmartTravelNotebook({
    required this.trip,
    required this.timeline,
    required this.liveContext,
    required this.memory,
  });

  final Trip trip;
  final List<TimelinePoi> timeline;
  final LiveContext liveContext;
  final List<String> memory;

  SmartTravelNotebook copyWith({
    Trip? trip,
    List<TimelinePoi>? timeline,
    LiveContext? liveContext,
    List<String>? memory,
  }) {
    return SmartTravelNotebook(
      trip: trip ?? this.trip,
      timeline: timeline ?? this.timeline,
      liveContext: liveContext ?? this.liveContext,
      memory: memory ?? this.memory,
    );
  }

  factory SmartTravelNotebook.initial() {
    return SmartTravelNotebook(
      trip: Trip(
        destination: 'Colombo',
        budget: 500.0,
        preferences: ['quiet cafes', 'history', 'walkable routes'],
      ),
      timeline: [],
      liveContext: LiveContext(),
      memory: ['User avoids steep hikes'],
    );
  }

  factory SmartTravelNotebook.fromJson(Map<String, dynamic> json) =>
      _$SmartTravelNotebookFromJson(json);
  Map<String, dynamic> toJson() => _$SmartTravelNotebookToJson(this);
}
