// lib/widgets/custom_app_bar.dart

import 'package:flutter/material.dart';
import 'package:habit_tracker_app/utils/app_colors.dart';
import 'package:habit_tracker_app/utils/image_urls.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const MyAppBar({Key? key, this.height = kToolbarHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background, // Customize as needed
      elevation: 0, // Remove shadow if desired
      centerTitle: true, // Center the title (logo)
      title: Image.asset(
        ImageUrls.appLogo,
        width: height, 
        height: height,
        fit: BoxFit.contain,
      ),
      automaticallyImplyLeading: false, // Remove back button if not needed
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
