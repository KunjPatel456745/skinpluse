import 'package:flutter/material.dart';
import 'app_colors.dart';

class ScoreColorHelper {
  static Color scoreColor(int score) {
    if (score >= 80 && score <= 100) {
      return AppColors.success;
    } else if (score >= 50 && score <= 79) {
      return AppColors.warning;
    } else {
      return AppColors.error;
    }
  }
}
