import 'package:flutter/material.dart';

abstract final class AppTheme {
  static ThemeData get outdoorHighContrast {
    const colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF0B3D91),
      onPrimary: Colors.white,
      secondary: Color(0xFF005F73),
      onSecondary: Colors.white,
      error: Color(0xFF9B2226),
      onError: Colors.white,
      surface: Color(0xFFF8FAFC),
      onSurface: Color(0xFF111827),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF0B3D91),
        foregroundColor: Colors.white,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 1.0,
      ),
    );
  }
}
