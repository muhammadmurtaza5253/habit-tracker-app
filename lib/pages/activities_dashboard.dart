import 'package:flutter/material.dart';
import 'package:habit_tracker_app/database_helper/database_helper.dart';
import 'package:habit_tracker_app/pages/AddHabitPage/add_habit_page.dart';
import 'package:habit_tracker_app/pages/components/dashboard_habit_card.dart';
import 'package:habit_tracker_app/pages/components/habit_card.dart';
import 'package:habit_tracker_app/pages/components/my_app_bar.dart';
import 'package:habit_tracker_app/pages/components/my_circular_progress.dart';
import 'package:habit_tracker_app/pages/penalty_not_paid.dart';
import 'package:habit_tracker_app/utils/app_colors.dart';
import 'package:habit_tracker_app/utils/app_text_styles.dart';

class ActivitiesDashboard extends StatefulWidget {
  const ActivitiesDashboard({super.key});

  @override
  State<ActivitiesDashboard> createState() => _ActivitiesDashboardState();
}

class _ActivitiesDashboardState extends State<ActivitiesDashboard> {
  bool isLoading = true;
  List userHabits = [];

  @override
  void initState() {
    super.initState();
    fetchHabitsFromDatabase();
  }

  Future<void> fetchHabitsFromDatabase() async {
    print('fetching habits from database...');
    final dbHelper = DatabaseHelper();
    final habits = await dbHelper.queryLastWeekHabits();
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      userHabits = habits;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: RefreshIndicator(
          onRefresh: fetchHabitsFromDatabase, // Trigger the refresh function
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Track your habits',
                    style: AppTextStyles.headline.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PenaltyNotPaidPage(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.history,
                      color: AppColors.secondary,
                      size: 35,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Mark the day for the each week you have followed the habit',
                style: AppTextStyles.body.copyWith(fontSize: 18),
              ),
              const SizedBox(height: 10),
              if (isLoading)
                Expanded(child: MyCircularProgress()),
              if (!isLoading && userHabits.isEmpty)
                Expanded(
                  child: Center(
                    child: Text(
                      'No habits yet, pull down to refresh.',
                      style: AppTextStyles.body.copyWith(fontSize: 18),
                    ),
                  ),
                ),
              if (!isLoading && userHabits.isNotEmpty)
                Expanded(
                  child: Container(
                        margin: const EdgeInsets.only(
                            bottom: 50), // Add your desired bottom margin here
                        child: ListView.builder(
                    itemCount: userHabits.length,
                    itemBuilder: (context, index) {
                      final habit = userHabits[index];
                      return DashboardHabitCard(
                        habit: habit,
                        onDelete: () async => await fetchHabitsFromDatabase(),
                      );
                    },
                  ),),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddHabitPage(
                onHabitAdded: () {
                  fetchHabitsFromDatabase();
                },
              ),
            ),
          );
        },
        backgroundColor: AppColors.secondary,
        child: const Icon(
          Icons.add,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
