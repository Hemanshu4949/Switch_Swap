import 'package:flutter/material.dart';

class AppLayout {
  // Spacing
  static const double xs = 4.0;
  static const double base = 8.0;
  static const double sm = 12.0;
  static const double paddingInner = 16.0;
  static const double md = 24.0; // Gutter / Container Padding
  static const double lg = 40.0;
  static const double xl = 64.0;

  // Margins
  static const double marginMobile = 16.0;
  static const double marginDesktop = 48.0;

  // Border Radii
  static const double radiusSm = 4.0;
  static const double radiusDefault = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0; // Standard for Cards & Buttons

  // Box Shadows (Elevation)
  static final List<BoxShadow> shadowLevel1 = [
    BoxShadow(
      color: const Color(0xFF333333).withValues(alpha: 0.04),
      blurRadius: 20,
      offset: const Offset(0, 4),
    ),
  ];

  static final List<BoxShadow> shadowLevel2 = [
    BoxShadow(
      color: const Color(0xFF333333).withValues(alpha: 0.08),
      blurRadius: 40,
      offset: const Offset(0, 12),
    ),
  ];
}