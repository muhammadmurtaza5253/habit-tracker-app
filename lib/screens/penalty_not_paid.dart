import 'package:flutter/material.dart';
import 'package:habit_tracker_app/logic/database_helper.dart';
import 'package:habit_tracker_app/screens/add_habit_page.dart';
import 'package:habit_tracker_app/screens/global_components/my_app_bar.dart';
import 'package:habit_tracker_app/screens/global_components/my_circular_progress.dart';
import 'package:habit_tracker_app/screens/global_components/no_habit_prompt.dart';
import 'package:habit_tracker_app/screens/global_components/no_unpaid_penalty_prompt.dart';
import 'package:habit_tracker_app/utils/app_colors.dart';
import 'package:habit_tracker_app/utils/app_text_styles.dart';
import 'package:habit_tracker_app/screens/global_components/habit_card.dart';

class PenaltyNotPaidPage extends StatefulWidget {
  const PenaltyNotPaidPage({super.key});

  @override
  State<PenaltyNotPaidPage> createState() => _PenaltyNotPaidPageState();
}

class _PenaltyNotPaidPageState extends State<PenaltyNotPaidPage> {
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
    final habits = await dbHelper.queryOldHabitsWithUnpaidPenalties();
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
          onRefresh: () async => fetchHabitsFromDatabase(),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pay the Penalty',
                    style: AppTextStyles.headline.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Calculate your points and pay the penalty for habits you missed',
                    style: AppTextStyles.body.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 24),
                  if (isLoading) Expanded(child: MyCircularProgress()),
                  if (!isLoading && userHabits.isNotEmpty)
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(
                            bottom: 50), // Add your desired bottom margin here
                        child: ListView.builder(
                          itemCount: userHabits.length,
                          itemBuilder: (context, index) {
                            final habit = userHabits[index];
                            return HabitCard(
                              habit: habit,
                              isUnpaidPage: true,
                              onDelete: () async =>
                                  await fetchHabitsFromDatabase(),
                              onUpdate: () async => await fetchHabitsFromDatabase(),
                            );
                          },
                        ),
                      ),
                    ),
                ],
              ),
              if (!isLoading && userHabits.isEmpty)
                const Center(
                  child: NoUnpaidPenaltyPrompt(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
