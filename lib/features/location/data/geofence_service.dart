import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../media/application/audio_narration_service_provider.dart';
import '../../notebook/application/notebook_controller.dart';
import '../../notebook/domain/smart_travel_notebook.dart';

part 'geofence_service.g.dart';

class GeofenceService {
  GeofenceService(this._ref);

  final Ref _ref;
  StreamSubscription<Position>? _positionSub;
  final Set<String> _triggeredPoiIds = <String>{};

  Future<void> startTracking() async {
    final hasPermission = await _requestPermissions();
    if (!hasPermission) return;

    // Keep updates active for near real-time geofencing.
    // Background behavior requires platform config in AndroidManifest/Info.plist.
    _positionSub = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 5,
      ),
    ).listen(_onPosition);
  }

  Future<void> stopTracking() async {
    await _positionSub?.cancel();
    _positionSub = null;
  }

  Future<bool> _requestPermissions() async {
    final enabled = await Geolocator.isLocationServiceEnabled();
    if (!enabled) return false;

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  Future<void> _onPosition(Position position) async {
    final controller = _ref.read(notebookControllerProvider.notifier);
    controller.applyLocationUpdate(
      latitude: position.latitude,
      longitude: position.longitude,
    );

    final notebook = _ref.read(notebookControllerProvider);
    final nearbyPoi = _nearestPoiWithin15m(
      timeline: notebook.timeline,
      latitude: notebook.liveContext.latitude,
      longitude: notebook.liveContext.longitude,
    );
    if (nearbyPoi == null || _triggeredPoiIds.contains(nearbyPoi.id)) return;

    _triggeredPoiIds.add(nearbyPoi.id);
    controller.markPoiStatus(nearbyPoi.id, PoiStatus.arrived);
    await _ref.read(audioNarrationServiceProvider).playNarration(nearbyPoi.audioUrl);
  }

  TimelinePoi? _nearestPoiWithin15m({
    required List<TimelinePoi> timeline,
    required double latitude,
    required double longitude,
  }) {
    for (final poi in timeline.where((poi) => poi.status == PoiStatus.pending)) {
      final distanceMeters = Geolocator.distanceBetween(
        latitude,
        longitude,
        poi.latitude,
        poi.longitude,
      );
      if (distanceMeters <= 15) return poi;
    }
    return null;
  }
}

@Riverpod(keepAlive: true)
GeofenceService geofenceService(Ref ref) {
  final service = GeofenceService(ref);
  ref.onDispose(service.stopTracking);
  return service;
}
