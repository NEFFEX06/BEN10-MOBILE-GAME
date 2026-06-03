import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: const Color(0xFF00B4D8),
      scaffoldBackgroundColor: const Color(0xFF0A1628),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF0F2847),
        elevation: 0,
        centerTitle: true,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Color(0xFF00B4D8),
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: Colors.white70,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00B4D8),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  // Color Palette
  static const Color primaryColor = Color(0xFF00B4D8);
  static const Color accentColor = Color(0xFFFF006E);
  static const Color backgroundColor = Color(0xFF0A1628);
  static const Color cardBackground = Color(0xFF0F2847);
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Colors.white70;
}
