import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/design_system/app_spacing.dart';
import '../../location/application/mock_location_toggle.dart';
import '../../location/data/geofence_service.dart';
import '../../location/presentation/navigation_map.dart';
import '../../media/presentation/ar_overlay_view.dart';
import '../application/notebook_controller.dart';

class NotebookHomePage extends ConsumerStatefulWidget {
  const NotebookHomePage({super.key});

  @override
  ConsumerState<NotebookHomePage> createState() => _NotebookHomePageState();
}

class _NotebookHomePageState extends ConsumerState<NotebookHomePage> {
  late final geofence = ref.read(geofenceServiceProvider);

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await ref.read(notebookControllerProvider.notifier).generateInitialPlan();
      await geofence.startTracking();
    });
  }

  @override
  void dispose() {
    geofence.stopTracking();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notebook = ref.watch(notebookControllerProvider);
    final notebookCtrl = ref.read(notebookControllerProvider.notifier);
    final mockLocation = ref.watch(mockLocationToggleProvider);
    final nearestPending = notebook.timeline
        .where((poi) => poi.status.name == 'pending')
        .firstOrNull;

    return Scaffold(
      appBar: AppBar(title: const Text('SmartTour Pro Notebook')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Destination: ${notebook.trip.destination}'),
                  Text('Budget: \$${notebook.trip.budget.toStringAsFixed(0)}'),
                  Text('Weather: ${notebook.liveContext.weather}'),
                  AppSpacing.vSm,
                  Row(
                    children: [
                      const Text('Mock Location'),
                      const Spacer(),
                      Switch(
                        value: mockLocation.enabled,
                        onChanged: (value) => ref
                            .read(mockLocationToggleProvider.notifier)
                            .toggle(value),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          AppSpacing.vMd,
          NavigationMap(
            timeline: notebook.timeline,
            liveContext: notebook.liveContext,
          ),
          AppSpacing.vMd,
          ArOverlayView(currentPoi: nearestPending),
          AppSpacing.vMd,
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              FilledButton(
                onPressed: () => notebookCtrl.replanForWeather('Rainy'),
                child: const Text('Trigger Rain Replan'),
              ),
              FilledButton.tonal(
                onPressed: () => notebookCtrl.replanForWeather('Clear'),
                child: const Text('Reset Weather Clear'),
              ),
            ],
          ),
          AppSpacing.vMd,
          Text('Timeline', style: Theme.of(context).textTheme.titleLarge),
          AppSpacing.vSm,
          ...notebook.timeline.map(
            (poi) => Card(
              child: ListTile(
                title: Text(poi.title),
                subtitle: Text(
                  '${poi.whySuggested}\nStatus: ${poi.status.name}',
                ),
                isThreeLine: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
