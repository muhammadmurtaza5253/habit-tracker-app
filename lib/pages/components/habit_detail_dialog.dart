import 'package:flutter/material.dart';
import 'package:habit_tracker_app/database_helper/database_helper.dart';
import 'package:habit_tracker_app/pages/components/unpaid_page_actions.dart';
import 'package:habit_tracker_app/utils/app_colors.dart';
import 'package:habit_tracker_app/utils/app_text_styles.dart';
import 'package:habit_tracker_app/habit_helpers/helpers.dart';

void showHabitDetailsDialog(
    BuildContext context, final Map? habit, final VoidCallback? onDelete,
    {bool isUnpaidPage = true, deleteHabit, final VoidCallback? onUpdate}) {
  bool isDeleting = false;
  bool isPledged = false; // Track if the pledge has been entered
  final TextEditingController pledgeController =
      TextEditingController(); // Controller for the pledge input

  int points = Helpers()
      .calculatePoints(habit); // Calculate points based on the habit data

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: AppColors.background,
            title: Text(
              habit?['name'] ?? 'No habit name',
              style: AppTextStyles.headline.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.secondary,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  habit?['description'] ?? 'No description',
                  style: AppTextStyles.body.copyWith(fontSize: 18),
                ),
                const SizedBox(height: 16),
                Text(
                  'Penalty: ${habit?['penalty'] ?? 'No penalty'}',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                // Points Text
                if (points > 0)
                  Text(
                    'For this activity, you have -${points} points.',
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.error,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                else
                  Text(
                    'You are going good!',
                    style: AppTextStyles.body.copyWith(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                const SizedBox(height: 16),
                // Show pledge input if isUnpaidPage is true
                if (isUnpaidPage) ...[
                  TextField(
                    controller: pledgeController,
                    decoration: InputDecoration(
                      hintText:
                          "I pledge that I have honestly paid the penalty for the task I didn't complete.",
                      errorText: pledgeController.text.isEmpty
                          ? 'Please enter your pledge.'
                          : null,
                    ),
                    onChanged: (value) {
                      setState(() {
                        isPledged = value.isNotEmpty; // Update pledge state
                      });
                    },
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
                            print("Updating the habit with updated penalty");
                            await DatabaseHelper().updatePenalty(habit?['id']);
                            if (onUpdate != null) onUpdate();
                            Navigator.of(context).pop();
                          }
                        : null,
                    child: Text(
                      'Submit',
                      style: AppTextStyles.body.copyWith(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.green), // Green background color
                    ),
                    onPressed: () async {
                      await DatabaseHelper().updatePenalty(habit?['id']);
                      if (onUpdate != null) onUpdate();
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'I completed this habit',
                      style: AppTextStyles.body
                          .copyWith(color: Colors.white), // White text color
                    ),
                  ),
                ],
              ],
            ),
            actions: <Widget>[
              // Only show delete button if isUnpaidPage is false
              if (!isUnpaidPage) ...[
                UnPaidPageActions(
                  isDeleting: isDeleting,
                  deleteHabit: (context) async {
                    setState(() {
                      isDeleting = true;
                    });
                    await deleteHabit(context);
                    setState(() {
                      isDeleting = false;
                    });
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                  onOkPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ],
          );
        },
      );
    },
  );
}
