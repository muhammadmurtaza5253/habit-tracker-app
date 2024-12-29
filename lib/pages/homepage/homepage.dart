import 'package:flutter/material.dart';
import 'package:habit_tracker_app/pages/AddHabitPage/add_habit_page.dart';
import 'package:habit_tracker_app/pages/activities_dashboard.dart';
import 'package:habit_tracker_app/pages/components/my_app_bar.dart';
import 'package:habit_tracker_app/pages/homepage/components/CrushingIt.dart';
import 'package:habit_tracker_app/pages/homepage/components/DaysUsed.dart';
import 'package:habit_tracker_app/pages/homepage/components/DonatedCharities.dart';
import 'package:habit_tracker_app/pages/homepage/components/GradientButton.dart';
import 'package:habit_tracker_app/pages/homepage/components/NegativePointsContainer.dart';
import 'package:habit_tracker_app/pages/homepage/components/PointsDisplay.dart';
import 'package:habit_tracker_app/pages/homepage/components/QuoteDialog.dart';
import 'package:habit_tracker_app/pages/homepage/components/ViewAddHabitComponent.dart';
import 'package:habit_tracker_app/pages/homepage/components/WeekCards.dart';
import 'package:habit_tracker_app/utils/image_urls.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // WeekCards remains fixed at the top
              const WeekCards(),
              // The rest of the content is scrollable
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const CrushingItWidget(),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            ImageUrls.feelingDownImage,
                            width: 100,
                            height: 100,
                          ),
                          Column(
                            children: [
                              const Text(
                                'Feeling down? Take motivation!',
                                style: TextStyle(fontSize: 14),
                              ),
                              const SizedBox(height: 10,),
                               ElevatedButton(
                                  onPressed: () {
                                    // Define the action on button press
                                   _showBottomDialog(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.purple, // Background color of the button
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          30), // Circular border radius
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 12), // Padding inside button
                                    elevation:
                                        5, // Button elevation for shadow effect
                                  ),
                                  child: const SizedBox(
                                    width: 220,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Take Motivation',
                                          style: TextStyle(
                                            color: Colors.white, // Text color
                                            fontSize: 13,
                                          ),
                                        ),
                                        SizedBox(
                                            width:
                                                8), // Space between text and icon
                                        Icon(
                                          size: 16,
                                          Icons.arrow_forward, // Right arrow icon
                                          color: Colors.white, // Icon color
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              
                            ],
                          ),
                        ],
                      ),

                      DaysUsed(),

                      NegativePointsContainer(),

                      ViewAddHabitComponent()


                      // PointsDisplay(positivePoints: 0, negativePoints: 0),
                      // const SizedBox(height: 15),
                      // const DonatedCharitiesSection(),
                      // const SizedBox(height: 15),
                      // Image.asset(
                      //   ImageUrls.successImage,
                      //   width: 100,
                      //   height: 100,
                      // ),
                      // const SizedBox(height: 20),
                      // GradientButton(
                      //   onPressed: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(builder: (_) => const AddHabitPage()),
                      //     );
                      //   },
                      //   buttonName: 'Add a habit for this week!',
                      // ),
                      // const SizedBox(height: 10),
                      // Image.asset(
                      //   ImageUrls.viewHabitsImage,
                      //   width: 100,
                      //   height: 100,
                      // ),
                      // const SizedBox(height: 10),
                      // GradientButton(
                      //   onPressed: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(builder: (_) => const ActivitiesDashboard()),
                      //     );
                      //   },
                      //   buttonName: 'View the habits',
                      // ),
                      // const SizedBox(height: 15),
                      // const Text(
                      //   "Error loading some parts of the app... please refresh",
                      // ),
                      // const Text(
                      //   "Please check config as database might not load",
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _showBottomDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows the dialog to be scrollable
      builder: (BuildContext context) {
        // Use the BottomDialog component and pass the quote and author dynamically
        return const QuoteDialog(
          quote: "Either you run the day or the day runs you",
          author: "Jim Rohn",
        );
      },
    );
  }
}

