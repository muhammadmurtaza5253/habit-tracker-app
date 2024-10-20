import 'package:flutter/material.dart';
import 'package:habit_tracker_app/utils/app_colors.dart';
import 'package:habit_tracker_app/utils/app_text_styles.dart';
import 'package:habit_tracker_app/utils/image_urls.dart';

class NoHabitsPrompt extends StatelessWidget {
  const NoHabitsPrompt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Display an image
          Image.asset(
            ImageUrls.oopsImage, // Ensure the image path is correct
            width: 250,
            height: 250,
          ),
          // Display the text
          Text(
            'Seems like you have no habits to follow',
            style: AppTextStyles.body.copyWith(
              fontSize: 18,
              color: AppColors.secondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
