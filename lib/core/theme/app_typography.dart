import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  static const String fontFamily = 'Sora'; // Assuming Sora is declared in pubspec.yaml

  static TextTheme getTextTheme() {
    return TextTheme(
      headlineLarge: GoogleFonts.sora(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 40 / 32,
        letterSpacing: -0.64, // -0.02em * 32
        color: const Color(0xFF1B1C1C),
      ),
      headlineMedium:   GoogleFonts.sora(

        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 32 / 24,
        color: Color(0xFF1B1C1C),
      ),
      headlineSmall:  GoogleFonts.sora(

        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 28 / 20,
        color: Color(0xFF1B1C1C),
      ),
      bodyLarge:   GoogleFonts.sora(

        fontSize: 18,
        fontWeight: FontWeight.w400,
        height: 28 / 18,
        color: Color(0xFF1B1C1C),
      ),
      bodyMedium:   GoogleFonts.sora(

        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 24 / 16,
        color: Color(0xFF1B1C1C),
      ),
      bodySmall:   GoogleFonts.sora(

        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 20 / 14,
        color: Color(0xFF1B1C1C),
      ),
      labelLarge:   GoogleFonts.sora(

        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 20 / 14,
        letterSpacing: 0.14, // 0.01em * 14
      ),
      labelMedium:   GoogleFonts.sora(

        fontSize: 12,
        fontWeight: FontWeight.w600,
        height: 16 / 12,
        letterSpacing: 0.48, // 0.04em * 12
      ),
      labelSmall:   GoogleFonts.sora(

        fontSize: 10,
        fontWeight: FontWeight.w700,
        height  : 14 / 10,
        letterSpacing: 0.5, // 0.05em * 10
      ),
    );
  }
}