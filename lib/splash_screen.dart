import 'dart:async';

import 'package:flutter/material.dart';
import 'package:habit_tracker_app/logic/database_helper.dart';
import 'package:habit_tracker_app/screens/add_habit_page.dart';
import 'package:habit_tracker_app/screens/homepage.dart';
import 'package:habit_tracker_app/screens/view_habits_page.dart';
import 'package:habit_tracker_app/utils/image_urls.dart';

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

  @override
  void initState() {
    super.initState();

    cleanDatabase();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ViewHabitsPage()));
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
