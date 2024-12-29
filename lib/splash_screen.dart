import 'dart:async';
import 'package:flutter/material.dart';
import 'package:habit_tracker_app/database_helper/database_helper.dart';
import 'package:habit_tracker_app/pages/activities_dashboard.dart';
import 'package:habit_tracker_app/pages/AddHabitPage/add_habit_page.dart';
import 'package:habit_tracker_app/pages/homepage/homepage.dart';
import 'package:habit_tracker_app/pages/onboarding_screen.dart';
import 'package:habit_tracker_app/pages/view_habits_page.dart';
import 'package:habit_tracker_app/utils/image_urls.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  Future<void> cleanDatabase() async {
    print('cleaning the database with old habits...');
    await DatabaseHelper().cleanOldHabits();
  }

  // Check if this is the first time the app is launched
  Future<void> checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true; // Default to true if not found

    // Navigate to the appropriate screen based on isFirstTime value
    if (isFirstTime) {
      // First time user: show onboarding and update the value to false
      prefs.setBool('isFirstTime', false);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    } else {
      // Not first time: go to the view habits page
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Homepage()),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    // Clean old habits from the database
    cleanDatabase();

    // Initialize animation controller for splash screen logo fade-in
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    // After splash screen duration, check if it’s the user’s first time
    Timer(const Duration(seconds: 3), () {
      checkFirstTime(); // Call function to check SharedPreferences and navigate
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Image.asset(
            ImageUrls.appLogo,
            width: 150,
            height: 150,
          ),
        ),
      ),
    );
  }
}
