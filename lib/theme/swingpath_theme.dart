import 'package:flutter/material.dart';

abstract final class SwingPathColors {
  static const background = Color(0xFF0A0C0F);
  static const surface = Color(0xFF141820);
  static const surfaceElevated = Color(0xFF1C2129);
  static const border = Color(0xFF2A3038);

  static const accent = Color(0xFF22E67A);
  static const accentDark = Color(0xFF0D8F4A);
  static const accentGlow = Color(0x4022E67A);

  static const textPrimary = Color(0xFFF5F7FA);
  static const textSecondary = Color(0xFF8B939E);
  static const textMuted = Color(0xFF5C6470);

  static const swingScore = Color(0xFF22E67A);
  static const clubSpeed = Color(0xFFF5C842);
  static const swings = Color(0xFF5EB3FF);
  static const focusBlue = Color(0xFF6EC1FF);
}

ThemeData buildSwingPathTheme() {
  const colorScheme = ColorScheme.dark(
    surface: SwingPathColors.surface,
    onSurface: SwingPathColors.textPrimary,
    primary: SwingPathColors.accent,
    onPrimary: SwingPathColors.background,
  );

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: SwingPathColors.background,
    colorScheme: colorScheme,
    fontFamily: 'Roboto',
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: SwingPathColors.textPrimary,
        letterSpacing: -0.5,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: SwingPathColors.textPrimary,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: SwingPathColors.textPrimary,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: SwingPathColors.textPrimary,
      ),
      bodyLarge: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: SwingPathColors.textPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: SwingPathColors.textSecondary,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
        color: SwingPathColors.textMuted,
      ),
    ),
  );
}
