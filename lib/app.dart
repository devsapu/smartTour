import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/notebook/presentation/notebook_home_page.dart';

class SmartTourApp extends StatelessWidget {
  const SmartTourApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartTour Pro',
      theme: AppTheme.outdoorHighContrast,
      home: const NotebookHomePage(),
    );
  }
}
