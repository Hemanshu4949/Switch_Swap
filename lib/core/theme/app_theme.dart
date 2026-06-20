import 'package:flutter/material.dart';
import '../constants/app_layout.dart';
import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: AppColors.colorScheme,
      scaffoldBackgroundColor: AppColors.surface,
      textTheme: AppTypography.getTextTheme(),

      // Card Component
      cardTheme: CardThemeData(
        color: AppColors.surfaceContainerLowest, // Pure White
        elevation: 0, // Using custom shadows via Container usually, but setting baseline here
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppLayout.radiusXl), // 24px
        ),
        margin: EdgeInsets.zero,
      ),

      // Button Component (Vibrant Coral Primary)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryContainer,
          foregroundColor: AppColors.onPrimary,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: AppLayout.md, vertical: AppLayout.sm),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppLayout.radiusXl), // 24px
          ),
          textStyle: AppTypography.getTextTheme().labelLarge,
        ),
      ),

      // Input Fields Component
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceContainerLow, // Light Cream Tint
        contentPadding: const EdgeInsets.all(AppLayout.paddingInner),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppLayout.radiusMd), // 12px
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppLayout.radiusMd),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppLayout.radiusMd),
          borderSide: const BorderSide(
            color: AppColors.primaryContainer, // Vibrant Coral Focus
            width: 2.0,
          ),
        ),
      ),

      // Chips/Tags Component (Bright Purple)
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.secondaryContainer,
        labelStyle: TextStyle(
          color: AppColors.onSecondary,
          fontFamily: AppTypography.fontFamily,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
        padding: const EdgeInsets.symmetric(horizontal: AppLayout.sm, vertical: AppLayout.xs),
        shape: const StadiumBorder(), // Pill-shaped as requested
        side: BorderSide.none,
      ),

      // List Divider
      dividerTheme: const DividerThemeData(
        color: Color(0x0D333333), // 5% opacity Charcoal
        thickness: 1,
        space: AppLayout.md,
      ),

      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryContainer;
          }
          return Colors.transparent;
        }),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppLayout.radiusSm), // 4px radius
        ),
      ),
    );
  }
}