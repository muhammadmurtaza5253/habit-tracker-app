import 'package:flutter/material.dart';
import 'package:habit_tracker_app/database_helper/database_helper.dart';
import 'package:habit_tracker_app/pages/components/habit_detail_dialog.dart';
import 'package:habit_tracker_app/utils/app_colors.dart'; // Import your colors
import 'package:habit_tracker_app/utils/app_text_styles.dart'; // Import your text styles

class HabitCard extends StatefulWidget {
  final Map? habit;
  final VoidCallback? onDelete;
  final VoidCallback? onUpdate;
  bool isUnpaidPage;

  HabitCard({
    this.habit,
    this.onDelete,
    this.onUpdate,
    this.isUnpaidPage = false,
    super.key,
  });

  @override
  State<HabitCard> createState() => _HabitCardState();
}

class _HabitCardState extends State<HabitCard> {
  deleteHabit(BuildContext context) async {
    try {
      await DatabaseHelper().delete(widget.habit?['id']);
      if (widget.onDelete != null) widget.onDelete!();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Habit was deleted successfully!')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Habit was not deleted successfully! $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.habit?['id'].toString() ?? '0'),
      background: Container(
        color: AppColors.error,
        alignment: Alignment.centerRight,
        // padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) async {
        deleteHabit(context);
      },
      child: GestureDetector(
        onTap: () {
          showHabitDetailsDialog(context, widget.habit, widget.onDelete,
              deleteHabit: deleteHabit,
              isUnpaidPage: widget.isUnpaidPage,
              onUpdate: widget.onUpdate);
        },
        child: SizedBox(
          width: double.infinity, 
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: AppColors.surface,
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8), // Optional margin
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.habit?['name'] ?? '',
                    style: AppTextStyles.headline.copyWith(
                      fontSize: 20,
                      color: AppColors.secondary,
                    ),
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
        ),
      ),
    );
  }
}
