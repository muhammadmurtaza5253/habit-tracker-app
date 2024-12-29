import 'package:flutter/material.dart';
import 'package:habit_tracker_app/database_helper/database_helper.dart';
import 'package:habit_tracker_app/pages/components/my_button.dart';
import 'package:habit_tracker_app/pages/components/my_textfield.dart';
import 'package:habit_tracker_app/utils/app_colors.dart';
import 'package:habit_tracker_app/utils/app_text_styles.dart';

class HabitForm extends StatefulWidget {
  final VoidCallback? onHabitAdded;

  const HabitForm({super.key, this.onHabitAdded});

  @override
  State<HabitForm> createState() => _HabitFormState();
}

class _HabitFormState extends State<HabitForm> {
  final TextEditingController _habitNameController = TextEditingController();
  final TextEditingController _penaltyController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  bool isLoading = false;

  clearControllers() {
    _habitNameController.clear();
    _descriptionController.clear();
    _penaltyController.clear();
  }

  void insertHabit(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    String name = _habitNameController.text.trim();
    String description = _descriptionController.text.trim();
    String penalty = _penaltyController.text.trim();

    if (name.isNotEmpty && description.isNotEmpty && penalty.isNotEmpty) {
      Map<String, dynamic> habitData = {
        'name': name,
        'description': description,
        'penalty': penalty,
      };

      try {
        await DatabaseHelper().insert(habitData);
        await Future.delayed(const Duration(seconds: 1));
        _habitNameController.clear();
        _descriptionController.clear();
        _penaltyController.clear();
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Habit added successfully')));

          // Close the keyboard
          FocusScope.of(context).unfocus();

          widget.onHabitAdded?.call(); // Call the callback here
        }
      } catch (e) {
        print(e);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill out all fields')));
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyTextField(
          controller: _habitNameController,
          hintText: 'Enter Habit name',
          labelText: 'Habit Name',
        ),
        const SizedBox(height: 24),
        // Habit Name Input
        MyTextField(
          controller: _descriptionController,
          hintText: 'Enter Description',
          labelText: 'Description for your habit',
          lines: 3,
        ),
        const SizedBox(height: 24),
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
            icon:
                const Icon(Icons.info_outline, color: AppColors.textSecondary),
            onPressed: () {
              _showInfoDialog(context);
            },
          ),
        ),
        const SizedBox(height: 32),
        MyButton(
            buttonText: 'Add',
            onPressed: () => {print("Habit is inserted")},
            isLoading: isLoading)
      ],
    );
  }
}

void _showInfoDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Penalty Information',
            style: AppTextStyles.headline
                .copyWith(fontSize: 20, color: Colors.purple)),
        content: Text(
          'If you fail to follow this habit, you will have to pay the penalty you mention here, so be wise about it :)',
          style: AppTextStyles.body,
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK', style: TextStyle(color: Colors.purple)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
