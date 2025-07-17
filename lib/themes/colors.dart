import 'package:flutter/material.dart';

/// Paleta de colores global y minimalista para la app de reproductor de música.
class AppColors {
  /// Fondo principal oscuro.
  static const Color primaryDark = Color(0xFF1a1a1a);
  /// Fondo secundario oscuro.
  static const Color secondaryDark = Color(0xFF222222);
  /// Color de acento para detalles y controles activos.
  static const Color accentColor = Colors.blueAccent;

  /// Fondo del reproductor y paneles.
  static const Color playerBackground = Color(0xFF222222);
  /// Fondo del panel colapsado/miniplayer.
  static const Color collapsedBackground = Color.fromARGB(255, 29, 29, 33);
  /// Fondo del panel expandido.
  static const Color panelBackground = Color(0xFF222222);

  /// Color principal para textos.
  static const Color textPrimary = Colors.white;
  /// Color secundario para textos menos importantes.
  static const Color textSecondary = Colors.white70;
  /// Color para textos oscuros (si se usa sobre fondos claros).
  static const Color textDark = Colors.black;
}
