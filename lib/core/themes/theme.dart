import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primary = Color(0xFF000000);
  static const Color scaffoldBackgroundColor = Color(0xFF1E1E1E);

  static final theme = ThemeData(
    primaryColor: primary,
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    fontFamily: GoogleFonts.orbitron().fontFamily,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color: Colors.white,
      ),
    ),
  );
}
