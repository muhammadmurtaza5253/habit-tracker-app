import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const TextStyle headline = TextStyle(
    color: AppColors.textPrimary,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle body = TextStyle(
    color: AppColors.textSecondary, // Lighter text color for body content
    fontSize: 16,
  );

  static const TextStyle dropdown = TextStyle(
    color: AppColors.textPrimary,
    fontSize: 16,
  );
}
