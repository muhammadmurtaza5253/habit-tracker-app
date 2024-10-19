import 'package:flutter/material.dart';
import 'package:habit_tracker_app/screens/global_components/my_app_bar.dart';
import 'package:habit_tracker_app/screens/global_components/my_button.dart';
import 'package:habit_tracker_app/screens/global_components/my_textfield.dart';
import 'package:habit_tracker_app/utils/app_colors.dart';
import 'package:habit_tracker_app/utils/app_text_styles.dart';
import 'package:habit_tracker_app/utils/globals.dart';

class AddHabitPage extends StatefulWidget {
  @override
  _AddHabitPageState createState() => _AddHabitPageState();
}

class _AddHabitPageState extends State<AddHabitPage> {
  final TextEditingController _habitNameController = TextEditingController();
  final TextEditingController _penaltyController = TextEditingController();
  String _selectedFrequency = '3 Days';

  final List<String> _frequencyOptions = ['3 Days', 'Week', 'Month', 'Year'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Section
              Text(
                'Add a new habit',
                style: AppTextStyles.headline.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              // Habit Name Input
              MyTextField(
                controller: _penaltyController,
                hintText: 'Enter Habit name',
                labelText: 'Habit Name',
              ),

              const SizedBox(height: 24),


              // Habit Name Input
              MyTextField(
                controller: _penaltyController,
                hintText: 'Enter Description',
                labelText: 'Description for your habit',
                lines: 3,
              ),

              const SizedBox(height: 24),
              // Frequency Dropdown
              // Text('Activity Timer',
              //     style: AppTextStyles.body.copyWith(fontSize: 18)),
              // const SizedBox(height: 8),
              // DropdownButtonFormField<String>(
              //   dropdownColor: AppColors.inputBackground,
              //   value: _selectedFrequency,
              //   items: _frequencyOptions.map((String value) {
              //     return DropdownMenuItem<String>(
              //       value: value,
              //       child: Text(value, style: AppTextStyles.body),
              //     );
              //   }).toList(),
              //   onChanged: (newValue) {
              //     setState(() {
              //       _selectedFrequency = newValue!;
              //     });
              //   },
              //   decoration: InputDecoration(
              //     filled: true,
              //     fillColor: AppColors.inputBackground,
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(16),
              //       borderSide: BorderSide.none,
              //     ),
              //     contentPadding:
              //         const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              //   ),
              //   isExpanded: true, // Makes the dropdown take up the full width
              //   icon: const Icon(Icons.arrow_drop_down,
              //       color: AppColors.textPrimary), // Adjust dropdown arrow icon
              //   iconSize: 24,
              //   style: AppTextStyles.body, // Text style inside the dropdown
              // ),

              // const SizedBox(height: 24),
              // Penalty Input
              MyTextField(
                controller: _penaltyController,
                hintText: 'Enter penalty',
                labelText: 'Penalty for not fulfilling',
                lines: 3,
              ),
              Container(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.info_outline, color: AppColors.textSecondary),
                  onPressed: () {
                    _showInfoDialog(context);
                  },
                ),
              ),

              const SizedBox(height: 32),
              // Save Button
              MyButton(buttonText: 'Add', onPressed: () => {}, isLoading: false)
            ],
          ),
        ),
      ),
    );
  }

  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Penalty Information', style: AppTextStyles.headline),
          content: Text(
            'If you fail to follow this habit, you will have to pay the penalty you mention here, so be wise about it :)',
            style: AppTextStyles.body,
          ),
          actions: <Widget>[
            TextButton(
              child:
                  const Text('OK', style: TextStyle(color: AppColors.primary)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
