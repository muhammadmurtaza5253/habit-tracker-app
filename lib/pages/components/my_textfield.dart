import 'package:flutter/material.dart';
import 'package:habit_tracker_app/utils/app_colors.dart'; // Import your colors
import 'package:habit_tracker_app/utils/app_text_styles.dart'; // Import your text styles

// ignore: must_be_immutable
class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  int lines; // New parameter to control the number of lines (height of TextField)

  MyTextField({
    required this.controller,
    required this.hintText,
    required this.labelText,
    this.lines = 1, // Default value for lines is set to 1
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: AppTextStyles.body.copyWith(fontSize: 18),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          style: AppTextStyles.body.copyWith(color: AppColors.textPrimary),
          maxLines: lines, // Set the maximum number of lines for the TextField
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.inputBackground,
            hintText: hintText,
            hintStyle: const TextStyle(color: AppColors.textSecondary),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }
}
