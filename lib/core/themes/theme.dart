import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primary = Color(0xFF000000);
  static const Color scaffoldBackgroundColor = Color(0xFF1E1E1E);

  static final theme = ThemeData(
    primaryColor: primary,
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    fontFamily: GoogleFonts.orbitron().fontFamily,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    textTheme: const TextTheme(
      bodySmall: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      bodyLarge: TextStyle(
        color: Colors.white,
        fontSize: 24,
      ),
    ),
  );
}

const gradients = [
  [Colors.blue, Colors.indigo],
  [Colors.pink, Colors.red],
  [Colors.yellow, Colors.orange],
  [Colors.green, Colors.lime],
];
