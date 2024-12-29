import 'package:flutter/material.dart';
import 'package:habit_tracker_app/utils/app_colors.dart'; // Import your colors
import 'package:habit_tracker_app/utils/app_text_styles.dart'; // Import your text styles

class HabitDaysSelection extends StatelessWidget {
  final List<bool> selectedDays;
  final Function(int index) onDayToggle;
  final Color selectedColor;
  final Color unselectedColor;
  final double circleSize;
  final double spacing;

  HabitDaysSelection({
    required this.selectedDays,
    required this.onDayToggle,
    this.selectedColor = AppColors.primary,
    this.unselectedColor = AppColors.secondary,
    this.circleSize = 40.0,
    this.spacing = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: spacing, // Adjust the space between circles
      alignment: WrapAlignment.start,
      children: List.generate(7, (index) {
        return GestureDetector(
          onTap: () => onDayToggle(index), // Handle circle tap
          child: Container(
            width: circleSize, // Adjust circle size if needed
            height: circleSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: selectedDays[index]
                    ? selectedColor
                    : unselectedColor, // Border color based on selection
                width: 2.0,
              ),
              color: selectedDays[index]
                  ? selectedColor
                  : Colors.transparent, // Fill color if selected
            ),
            child: Center(
              child: Text(
                (index + 1).toString(),
                style: AppTextStyles.body.copyWith(
                  color: selectedDays[index]
                      ? Colors.white
                      : unselectedColor, // Text color based on selection
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
