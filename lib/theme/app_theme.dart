import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Primary palette
  static const Color primaryBlue = Color(0xFF4A6CF7);
  static const Color primaryPurple = Color(0xFF9B51E0);
  static const Color accentCyan = Color(0xFF00D2FF);

  // Surface colors
  static const Color surface = Color(0xFF1A1A2E);
  static const Color surfaceLight = Color(0xFF232342);
  static const Color surfaceCard = Color(0xFF2A2A4A);
  static const Color surfaceCardLight = Color(0xFF33335A);

  // Status colors
  static const Color success = Color(0xFF00E676);
  static const Color warning = Color(0xFFFFAB40);
  static const Color danger = Color(0xFFFF5252);

  // Text colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB8B8D0);
  static const Color textMuted = Color(0xFF6E6E8A);

  // Gradients
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0F0C29), Color(0xFF302B63), Color(0xFF24243E)],
  );

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryBlue, primaryPurple],
  );

  static const LinearGradient scoreGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [accentCyan, primaryBlue, primaryPurple],
  );

  static const LinearGradient activeGlow = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF00E676), Color(0xFF00B0FF)],
  );

  // Card decoration
  static BoxDecoration cardDecoration({
    Color color = surfaceCard,
    double borderRadius = 20,
    bool hasGlow = false,
    Color glowColor = primaryBlue,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(40),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
        if (hasGlow)
          BoxShadow(
            color: glowColor.withAlpha(50),
            blurRadius: 24,
            spreadRadius: 2,
          ),
      ],
    );
  }

  // Theme data
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: surface,
      colorScheme: const ColorScheme.dark(
        primary: primaryBlue,
        secondary: primaryPurple,
        surface: surface,
        error: danger,
      ),
      textTheme: GoogleFonts.outfitTextTheme(
        ThemeData.dark().textTheme,
      ).apply(
        bodyColor: textPrimary,
        displayColor: textPrimary,
      ),
      cardTheme: CardThemeData(
        color: surfaceCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: surfaceCardLight,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
