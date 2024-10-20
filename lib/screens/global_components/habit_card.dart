import 'package:flutter/material.dart';
import 'package:habit_tracker_app/logic/database_helper.dart';
import 'package:habit_tracker_app/utils/app_colors.dart'; // Import your colors
import 'package:habit_tracker_app/utils/app_text_styles.dart'; // Import your text styles

class HabitCard extends StatefulWidget {
  final Map? habit;
  final VoidCallback? onDelete;

  const HabitCard({
    this.habit,
    this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  State<HabitCard> createState() => _HabitCardState();
}

class _HabitCardState extends State<HabitCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showHabitDetailsDialog(context, widget.habit, widget.onDelete);
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
                widget.habit?['name'] ?? '',
                style: AppTextStyles.headline
                    .copyWith(fontSize: 20, color: AppColors.secondary),
              ),
              const SizedBox(height: 8),
              Text(
                widget.habit?['description'] ?? '',
                style: AppTextStyles.body,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showHabitDetailsDialog(BuildContext context, final Map? habit, final VoidCallback? onDelete) {
    bool isDeleting = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            // Use StatefulBuilder to rebuild the dialog UI
            return AlertDialog(
              title: Text(
                habit?['name'] ?? 'No habit name',
                style: AppTextStyles.headline.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondary,
                ),
              ),
              content: Column(
                mainAxisSize:
                    MainAxisSize.min, // Adjust the dialog height to its content
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
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                // Row to position the delete icon on the left side
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Delete Icon on the left
                    IconButton(
                      icon: isDeleting
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                strokeWidth:
                                    2, // Thinner stroke to fit the button size
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.red), // Red color for the indicator
                              ),
                            )
                          : const Icon(Icons.delete, color: Colors.red),
                      onPressed: isDeleting
                          ? null // Disable the button when deleting
                          : () async {
                              setState(() {
                                isDeleting = true; // Set loading state
                              });

                              // Perform the deletion
                              await DatabaseHelper().delete(habit?['id']);
                              await Future.delayed(const Duration(
                                  seconds:
                                      2)); // Optional delay to show loading

                              setState(() {
                                isDeleting =
                                    false; // Set loading state back to false
                              });

                              (onDelete != null )? onDelete() : null; 

                              // Close the dialog after deletion
                              if (context.mounted) {
                                Navigator.of(context).pop();
                              }
                            },
                    ),
                    // OK button on the right
                    TextButton(
                      child: const Text('OK',
                          style: TextStyle(color: AppColors.primary)),
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}
