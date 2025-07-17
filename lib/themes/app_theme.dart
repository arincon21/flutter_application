import 'package:flutter/material.dart';
import 'colors.dart';

/// Tema global minimalista y profesional para la app de reproductor de música.
class AppTheme {
  /// Tema oscuro principal, coherente con la paleta de AppColors.
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.accentColor,
    scaffoldBackgroundColor: AppColors.primaryDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryDark,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
      centerTitle: true,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.textPrimary, fontSize: 16),
      bodyMedium: TextStyle(color: AppColors.textSecondary, fontSize: 14),
      titleLarge: TextStyle(color: AppColors.textPrimary, fontSize: 24, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(color: AppColors.textPrimary, fontSize: 18),
    ),
    iconTheme: const IconThemeData(color: AppColors.textPrimary),
    colorScheme: ColorScheme.dark(
      primary: AppColors.accentColor,
      background: AppColors.primaryDark,
      surface: AppColors.secondaryDark,
      onPrimary: AppColors.textPrimary,
      onSurface: AppColors.textPrimary,
    ),
    useMaterial3: true,
  );
}
