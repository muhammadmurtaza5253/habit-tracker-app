import 'package:flutter/material.dart';
import 'package:habit_tracker_app/screens/add_habit_page.dart';
import 'package:habit_tracker_app/screens/global_components/my_app_bar.dart';
import 'package:habit_tracker_app/utils/app_colors.dart';
import 'package:habit_tracker_app/utils/app_text_styles.dart';
import 'package:habit_tracker_app/screens/global_components/habit_card.dart'; // Import HabitCard

class ViewHabitsPage extends StatelessWidget {
  final List<Map<String, String>> userHabits = [
    {
      'habitName': 'Morning Jog',
      'description': 'Jog for 30 minutes every morning.',
      'penalty': 'Miss a day and pay 5.',
    },
    {
      'habitName': 'Read a Book',
      'description': 'Read 20 pages of a book daily.',
      'penalty': 'Skip a day and pay 3.',
    },
    {
      'habitName': 'Meditation',
      'description': 'Practice mindfulness for 15 minutes.',
      'penalty': 'Miss a session and pay 2.',
    },
  ];

  ViewHabitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            Text(
              'View your habits',
              style: AppTextStyles.headline.copyWith(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Body Text
            Text(
              'Look at your habits for this week',
              style: AppTextStyles.body.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 24),

            // Habit Cards List
            Expanded(
              child: ListView.builder(
                itemCount: userHabits.length,
                itemBuilder: (context, index) {
                  final habit = userHabits[index];
                  return HabitCard(
                    habitName: habit['habitName'],
                    description: habit['description'],
                    penalty: habit['penalty'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddHabitPage()));
        },
        backgroundColor: AppColors.secondary,
        child: const Icon(Icons.add, color: AppColors.primary,),
      ),
    );
  }
}
