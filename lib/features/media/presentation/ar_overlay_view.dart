import 'package:flutter/material.dart';

import '../../notebook/domain/smart_travel_notebook.dart';

class ArOverlayView extends StatelessWidget {
  const ArOverlayView({
    required this.currentPoi,
    super.key,
  });

  final TimelinePoi? currentPoi;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 220,
        color: Colors.black,
        child: Stack(
          fit: StackFit.expand,
          children: [
            const Center(
              child: Text(
                'Camera / AR overlay placeholder',
                style: TextStyle(color: Colors.white70),
              ),
            ),
            if (currentPoi != null)
              Align(
                alignment: Alignment.topCenter,
                child: Card(
                  margin: const EdgeInsets.all(12),
                  color: Colors.white.withValues(alpha: 0.95),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentPoi!.title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 6),
                        Text(currentPoi!.historicalContext),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
