import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static final TextStyle headline = GoogleFonts.poppins(
    color: AppColors.textPrimary,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle body = GoogleFonts.poppins(
    color: AppColors.textSecondary,
    fontSize: 14,
  );

  static final TextStyle dropdown = GoogleFonts.poppins(
    color: AppColors.textPrimary,
    fontSize: 16,
  );
}
