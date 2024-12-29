import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker_app/pages/activities_dashboard.dart';
import 'package:habit_tracker_app/pages/components/my_button.dart';
import 'package:habit_tracker_app/pages/homepage/homepage.dart';
import 'package:habit_tracker_app/pages/view_habits_page.dart';
import 'package:habit_tracker_app/utils/app_colors.dart';
import 'package:habit_tracker_app/utils/app_text_styles.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: [
                buildOnboardingPage(
                  "Track your habits with us.",
                  Icons.track_changes,
                ),
                buildOnboardingPage(
                  "Set penalties for missed days.",
                  Icons.alarm,
                ),
                buildOnboardingPage(
                  "Track your missed days and stay accountable.",
                  Icons.check_circle_outline,
                ),
              ],
            ),
          ),
          if (_currentPage == 2)
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20 ),
              child: MyButton(
                isLoading: false,
                buttonText: 'Homepage',
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => Homepage()));
                },
              ),
            ),
          const SizedBox(height: 20), // Add space at the bottom for modern feel
        ],
      ),
    );
  }

  Widget buildOnboardingPage(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 120,
            color: AppColors.accent,
          ),
          const SizedBox(height: 50),
          Text(
            text,
            style: AppTextStyles.headline.copyWith(fontSize: 28),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            "Swipe to continue",
            style: AppTextStyles.body.copyWith(color: AppColors.highlight),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
