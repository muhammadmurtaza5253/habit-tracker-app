import 'package:flutter/material.dart';
import 'package:habit_tracker_app/habit_helpers/helper.dart';
import 'package:habit_tracker_app/utils/app_colors.dart';
import 'package:habit_tracker_app/utils/app_text_styles.dart';

class TimeCard extends StatelessWidget {
  final helper = Helper();

  TimeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: RichText(
            text: TextSpan(
              style: AppTextStyles.body.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              children: [
                const TextSpan(
                  text: 'Current month: ',
                ),
                TextSpan(
                  text: helper.getCurrentMonth(),
                  style: const TextStyle(color: Colors.purple),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            helper.getCurrentWeekText(),
            style: AppTextStyles.headline.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
