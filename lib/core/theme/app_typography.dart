import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTypography {
  static const String headlineFont = 'Space Grotesk';
  static const String bodyFont = 'Manrope';
  static const String labelFont = 'Inter';

  static const TextStyle displayLarge = TextStyle(
    fontFamily: headlineFont,
    fontSize: 32.0,
    fontWeight: FontWeight.w700,
    color: AppColors.onBackground,
  );

  static const TextStyle headlineLarge = TextStyle(
    fontFamily: headlineFont,
    fontSize: 28.0,
    fontWeight: FontWeight.w700,
    color: AppColors.onBackground,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: headlineFont,
    fontSize: 24.0,
    fontWeight: FontWeight.w600,
    color: AppColors.onBackground,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontFamily: headlineFont,
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    color: AppColors.onBackground,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontFamily: bodyFont,
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    color: AppColors.onBackground,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: bodyFont,
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: AppColors.onBackground,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: bodyFont,
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurfaceVariant,
  );

  static const TextStyle labelLarge = TextStyle(
    fontFamily: labelFont,
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    color: AppColors.onBackground,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: labelFont,
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: AppColors.onBackground,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: labelFont,
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
    color: AppColors.onSurfaceVariant,
  );
}
