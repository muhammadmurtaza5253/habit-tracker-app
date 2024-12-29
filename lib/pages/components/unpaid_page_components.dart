import 'package:flutter/material.dart';
import 'package:habit_tracker_app/utils/app_colors.dart';
import 'package:habit_tracker_app/utils/app_text_styles.dart';

class UnPaidPageComponents extends StatelessWidget {
  final TextEditingController pledgeController;
  final bool isPledged;
  final Map? habit;
  final Future<void> Function()? onSubmit;
  final Future<void> Function()? onComplete;

  const UnPaidPageComponents({
    Key? key,
    required this.pledgeController,
    required this.isPledged,
    required this.habit,
    required this.onSubmit,
    required this.onComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: pledgeController,
          decoration: InputDecoration(
            hintText:
                "I pledge that I have honestly paid the penalty for the task I didn't complete.",
            errorText: pledgeController.text.isEmpty
                ? 'Please enter your pledge.'
                : null,
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              isPledged ? AppColors.secondary : AppColors.primary,
            ),
          ),
          onPressed: isPledged
              ? () async {
                  if (onSubmit != null) await onSubmit!();
                }
              : null,
          child: Text(
            'Submit',
            style: AppTextStyles.body.copyWith(color: Colors.white),
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              Colors.green, // Green background color
            ),
          ),
          onPressed: onComplete != null
              ? () async {
                  await onComplete!();
                }
              : null,
          child: Text(
            'I completed this habit',
            style: AppTextStyles.body.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
