import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../notebook/domain/smart_travel_notebook.dart';

class NavigationMap extends StatefulWidget {
  const NavigationMap({
    required this.timeline,
    required this.liveContext,
    super.key,
  });

  final List<TimelinePoi> timeline;
  final LiveContext liveContext;

  @override
  State<NavigationMap> createState() => _NavigationMapState();
}

class _NavigationMapState extends State<NavigationMap> {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    final markers = {
      for (final poi in widget.timeline)
        Marker(
          markerId: MarkerId(poi.id),
          position: LatLng(poi.latitude, poi.longitude),
          infoWindow: InfoWindow(title: poi.title, snippet: poi.whySuggested),
        ),
      Marker(
        markerId: const MarkerId('user'),
        position:
            LatLng(widget.liveContext.latitude, widget.liveContext.longitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        infoWindow: const InfoWindow(title: 'You'),
      ),
    };

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        height: 260,
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(
              widget.liveContext.latitude == 0
                  ? 6.9271
                  : widget.liveContext.latitude,
              widget.liveContext.longitude == 0
                  ? 79.8612
                  : widget.liveContext.longitude,
            ),
            zoom: 13,
          ),
          markers: markers,
          polylines: {
            Polyline(
              polylineId: const PolylineId('planned_route'),
              color: Theme.of(context).colorScheme.primary,
              width: 4,
              points: widget.timeline
                  .map((poi) => LatLng(poi.latitude, poi.longitude))
                  .toList(),
            ),
          },
          onMapCreated: (mapController) {
            if (!_controller.isCompleted) {
              _controller.complete(mapController);
            }
          },
        ),
      ),
    );
  }
}
