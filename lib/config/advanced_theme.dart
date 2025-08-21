import 'package:flutter/material.dart';

class CosmicTheme {
  static const Color cosmicPrimary = Color(0xFF6366F1);
  static const Color cosmicSecondary = Color(0xFF8B5CF6);
  static const Color cosmicAccent = Color(0xFF06B6D4);
  static const Color cosmicBackground = Color(0xFF0F172A);
  static const Color cosmicSurface = Color(0xFF1E293B);
  static const Color cosmicText = Color(0xFFF1F5F9);

  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      colorScheme: const ColorScheme.dark(
        primary: cosmicPrimary,
        secondary: cosmicSecondary,
        surface: cosmicSurface,
        background: cosmicBackground,
        onBackground: cosmicText,
      ),
      scaffoldBackgroundColor: cosmicBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: cosmicText,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w900,
          color: cosmicText,
          letterSpacing: -1.5,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w800,
          color: cosmicText,
          letterSpacing: -1.0,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: cosmicText,
          height: 1.6,
        ),
      ),
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        color: cosmicSurface.withOpacity(0.8),
      ),
    );
  }
}