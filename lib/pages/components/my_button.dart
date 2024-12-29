import 'package:flutter/material.dart';
import 'package:habit_tracker_app/pages/components/my_circular_progress.dart';
import 'package:habit_tracker_app/utils/app_colors.dart'; // Import your colors
import 'package:habit_tracker_app/utils/app_text_styles.dart'; // Import your text styles

class MyButton extends StatefulWidget {
  final String buttonText;
  final Function onPressed;
  final bool isLoading;

  const MyButton({
    required this.buttonText,
    required this.onPressed,
    required this.isLoading,
    Key? key,
  }) : super(key: key);

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: widget.isLoading
            ? null // Disable button if it's loading
            : () => widget.onPressed(),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          minimumSize: Size(MediaQuery.sizeOf(context).width, 50), // Set width dynamically
          backgroundColor: Colors.purple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 12,
          shadowColor: AppColors.primary.withOpacity(0.4),
        ),
        child: widget.isLoading
            ? MyCircularProgress(diameter: 15, strokeWidth: 2, color: AppColors.accent,)
            : Text(
                widget.buttonText,
                style: AppTextStyles.body.copyWith(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
      ),
    );
  }
}
