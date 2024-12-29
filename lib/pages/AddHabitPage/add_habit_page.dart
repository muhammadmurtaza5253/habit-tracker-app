import 'package:flutter/material.dart';
import 'package:habit_tracker_app/pages/AddHabitPage/components/habit_form.dart';
import 'package:habit_tracker_app/pages/AddHabitPage/components/time_card.dart';
import 'package:habit_tracker_app/pages/components/my_app_bar.dart';
import 'package:habit_tracker_app/utils/app_text_styles.dart';

class AddHabitPage extends StatefulWidget {
  final VoidCallback? onHabitAdded;
  const AddHabitPage({super.key, this.onHabitAdded});

  @override
  State<AddHabitPage> createState() => _AddHabitPageState();
}

class _AddHabitPageState extends State<AddHabitPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TimeCard(),
                  Text(
                    'Try to follow it religiously for one week!',
                    style: AppTextStyles.body.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const HabitForm()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
