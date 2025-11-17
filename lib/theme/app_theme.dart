import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData darkNeon() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF050814),

      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF00FF9C),        // Neon green
        secondary: Color(0xFF00C8FF),      // Neon blue
        surface: Color(0xFF0A0F1F),
      ),

      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Color(0xFF00FF9C),
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),

      cardTheme: CardTheme(
        color: const Color(0xFF0B1020),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(
            color: Color(0x22FFFFFF),
          ),
        ),
      ),
    );
  }
}
