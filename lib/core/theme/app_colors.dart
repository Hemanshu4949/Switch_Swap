import 'package:flutter/material.dart';

class AppColors {
  // Base Colors
  static const Color background = Color(0xFFFBF9F8); // Soft Cream
  static const Color onBackground = Color(0xFF1B1C1C); // Charcoal

  // Surfaces
  static const Color surface = Color(0xFFFBF9F8);
  static const Color surfaceDim = Color(0xFFDCD9D9);
  static const Color surfaceBright = Color(0xFFFBF9F8);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF); // Pure White (Cards)
  static const Color surfaceContainerLow = Color(0xFFF6F3F2);
  static const Color surfaceContainer = Color(0xFFF0EDED);
  static const Color surfaceContainerHigh = Color(0xFFEAE8E7);
  static const Color surfaceContainerHighest = Color(0xFFE4E2E1);
  static const Color onSurface = Color(0xFF1B1C1C);
  static const Color onSurfaceVariant = Color(0xFF584140);

  // Primary (Coral/Red tones)
  static const Color primary = Color(0xFFAE2F34);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFFFF6363); // Vibrant Coral
  static const Color onPrimaryContainer = Color(0xFF6D0010);

  // Secondary (Purple tones)
  static const Color secondary = Color(0xFF8433C4);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFBD6EFE); // Bright Purple
  static const Color onSecondaryContainer = Color(0xFF450073);

  // Error
  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF93000A);

  // Outlines
  static const Color outline = Color(0xFF8C706F);
  static const Color outlineVariant = Color(0xFFE0BFBD);

  //additional
  static const Color black = Color(0xFF000000);


  // Material 3 ColorScheme generation
  static const ColorScheme colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primaryContainer, // Promoted Vibrant Coral to primary UI action color per docs
    onPrimary: onPrimary,
    primaryContainer: primaryContainer,
    onPrimaryContainer: onPrimaryContainer,
    secondary: secondaryContainer, // Promoted Bright Purple to secondary UI action color
    onSecondary: onSecondary,
    secondaryContainer: secondaryContainer,
    onSecondaryContainer: onSecondaryContainer,
    error: error,
    onError: onError,
    errorContainer: errorContainer,
    onErrorContainer: onErrorContainer,
    surface: surface,
    onSurface: onSurface,
    outline: outline,
    outlineVariant: outlineVariant,
  );
}