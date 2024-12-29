import 'package:flutter/material.dart';
import 'package:habit_tracker_app/utils/app_colors.dart';

// ignore: must_be_immutable
class MyCircularProgress extends StatelessWidget {

  double diameter;
  double strokeWidth;
  Color color;

  MyCircularProgress(
      {super.key,
      this.diameter = 30,
      this.strokeWidth = 2,
      this.color = AppColors.secondary});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: diameter,
        height: diameter,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          color: color,
        ),
      ),
    );
  }
}
