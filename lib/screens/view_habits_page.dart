import 'package:flutter/material.dart';
import 'package:habit_tracker_app/logic/database_helper.dart';
import 'package:habit_tracker_app/screens/add_habit_page.dart';
import 'package:habit_tracker_app/screens/global_components/my_app_bar.dart';
import 'package:habit_tracker_app/utils/app_colors.dart';
import 'package:habit_tracker_app/utils/app_text_styles.dart';
import 'package:habit_tracker_app/screens/global_components/habit_card.dart';
import 'package:habit_tracker_app/utils/image_urls.dart'; // Import HabitCard

class ViewHabitsPage extends StatefulWidget {
  const ViewHabitsPage({super.key});

  @override
  State<ViewHabitsPage> createState() => _ViewHabitsPageState();
}

class _ViewHabitsPageState extends State<ViewHabitsPage> {
  bool isLoading = true;
  List userHabits = [];

  @override
  void initState() {
    super.initState();
    fetchHabitsFromDatabase();
  }

  // Function to fetch habits from the database
  Future<void> fetchHabitsFromDatabase() async {
    final dbHelper = DatabaseHelper();
    final habits = await dbHelper.queryLastWeekHabits(); // Fetch all habits
    setState(() {
      userHabits = habits;
      isLoading = false; // Set loading to false after fetching
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: RefreshIndicator(
          onRefresh: () async => {await fetchHabitsFromDatabase()},
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
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
                // Content
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: AppColors.secondary,
                      )) // Show loading indicator while fetching data
                    : userHabits
                            .isEmpty // Check if the userHabits list is empty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Display an image
                                Image.asset(
                                  ImageUrls
                                      .oopsImage, // Make sure the image path is correct
                                  width: 250,
                                  height: 250,
                                ),
                                // Display the text
                                Text(
                                  'Seems like you have no habits to follow',
                                  style: AppTextStyles.body.copyWith(
                                    fontSize: 18,
                                    color: AppColors.secondary,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: () async =>
                                await fetchHabitsFromDatabase(),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: userHabits.length,
                              itemBuilder: (context, index) {
                                final habit = userHabits[index];
                                return HabitCard(
                                  habit: habit,
                                  onDelete: () async => {
                                    await fetchHabitsFromDatabase(),
                                  },
                                );
                              },
                            ),
                          ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddHabitPage(
                onHabitAdded: () {
                  // Callback to refresh data
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
