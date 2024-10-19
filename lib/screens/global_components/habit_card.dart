import 'package:flutter/material.dart';
import 'package:habit_tracker_app/utils/app_colors.dart'; // Import your colors
import 'package:habit_tracker_app/utils/app_text_styles.dart'; // Import your text styles

class HabitCard extends StatelessWidget {
  final String? habitName;
  final String? description;
  final String? penalty;

  const HabitCard({
    this.habitName,
    this.description,
    this.penalty,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showHabitDetailsDialog(context, habitName, description, penalty);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: AppColors.inputBackground,
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                habitName ?? '',
                style: AppTextStyles.headline.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 8),
              Text(
                description ?? '',
                style: AppTextStyles.body,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showHabitDetailsDialog(BuildContext context, String? habitName,
      String? description, String? penalty) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            habitName ?? 'No habit name',
            style: AppTextStyles.headline
                .copyWith(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize:
                MainAxisSize.min, // Adjust the dialog height to its content
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description ?? 'No description',
                style: AppTextStyles.body.copyWith(fontSize: 18),
              ),
              const SizedBox(height: 16),
              Text(
                'Penalty: ${penalty ?? 'No penalty'}',
                style: AppTextStyles.body.copyWith(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child:
                  const Text('OK', style: TextStyle(color: AppColors.primary)),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}
