import 'package:flutter/material.dart';
import 'package:habit_tracker_app/database_helper/database_helper.dart';
import 'package:habit_tracker_app/pages/components/habit_detail_dialog.dart';
import 'package:habit_tracker_app/pages/components/habits_day_selection.dart';
import 'package:habit_tracker_app/utils/app_colors.dart'; // Import your colors
import 'package:habit_tracker_app/utils/app_text_styles.dart'; // Import your text styles
import 'package:habit_tracker_app/habit_helpers/helpers.dart'; // Import your text styles


class DashboardHabitCard extends StatefulWidget {
  final Map? habit;
  final VoidCallback? onDelete;
  final VoidCallback? onUpdate;
  bool isUnpaidPage;

  DashboardHabitCard({
    this.habit,
    this.onDelete,
    this.onUpdate,
    this.isUnpaidPage = false,
    super.key,
  });

  @override
  State<DashboardHabitCard> createState() => _DashboardHabitCardState();
}

class _DashboardHabitCardState extends State<DashboardHabitCard> {
  List<bool> selectedDays = List.generate(7, (index) => false);

  @override
  void initState() {
    super.initState();
    // Initialize the selectedDays based on 'track_attendance' string
    if (widget.habit?['track_attendance'] != null) {
      String trackAttendance = widget.habit!['track_attendance'];
      for (int i = 0; i < trackAttendance.length; i++) {
        int day = int.parse(trackAttendance[i]);
        if (day > 0 && day <= 7) {
          selectedDays[day - 1] = true; // Mark the day as selected
        }
      }
      setState(() {});
    }
  }

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

  void toggleDay(int index) {
    setState(() {
      selectedDays[index] = !selectedDays[index];
      String updatedTrackAttendance = '';
      for (int i = 0; i < selectedDays.length; i++) {
        if (selectedDays[i]) {
          updatedTrackAttendance += (i + 1).toString();
        }
      }

      if (widget.habit != null) {
        Map newHabit = Map<String, dynamic>.from(widget.habit!);
        newHabit['track_attendance'] = updatedTrackAttendance;
        updateDatabase(newHabit);
      }
    });
  }

  void updateDatabase(Map? updatedHabit) {
    print('updating the track attendance for habit...');
    if (updatedHabit != null) {
      DatabaseHelper().updateDays(updatedHabit);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Calculate points based on the habit data
    int points = Helpers().calculatePoints(widget.habit);
    // int points = 5;
    return GestureDetector(
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
            borderRadius: BorderRadius.circular(10),
          ),
          color: AppColors.surface,
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 8), // Optional margin
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row for title and points/thumb-up icon on the right
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.habit?['name'] ?? '',
                      style: AppTextStyles.headline.copyWith(
                        fontSize: 17,
                        color: AppColors.secondary,
                      ),
                    ),
                    points == 0
                        ? Icon(
                            Icons.thumb_up,
                            color: Colors.green,
                            size: 24,
                          )
                        : Text(
                            '-$points', // Display the points
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red, // Points in red if not zero
                            ),
                          ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  widget.habit?['description'] ?? '',
                  style: AppTextStyles.body,
                ),
                const SizedBox(height: 16),
                // Use the new HabitDaysSelection component here
                HabitDaysSelection(
                  selectedDays: selectedDays,
                  onDayToggle: toggleDay,
                  selectedColor: AppColors.primary,
                  unselectedColor: AppColors.secondary,
                  circleSize: 30.0,
                  spacing: 8.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


