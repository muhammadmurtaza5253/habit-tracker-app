import 'package:flutter/material.dart';
import 'package:habit_tracker_app/pages/AddHabitPage/add_habit_page.dart';
import 'package:habit_tracker_app/pages/view_habits_page.dart';

class ViewAddHabitComponent extends StatelessWidget {
  const ViewAddHabitComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
          width: double.infinity, // Take up the full available width
          height: 120, // Set the height
          decoration: BoxDecoration(
            color: Colors.white, // Background color of the container
            borderRadius: BorderRadius.circular(15), // Rounded corners
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4), // Shadow offset
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround, // Space out items on both sides
            children: [
              // Left side: View Icon and Text
              GestureDetector(
                onTap: ()=>{Navigator.push(context, MaterialPageRoute(builder: (_) => const ViewHabitsPage()))},
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.visibility, // View icon
                        size: 30,
                        color: Colors.purple,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'View Habits',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Divider in the middle
              const VerticalDivider(
                thickness: 1,
                color: Colors.grey,
                width: 20,
              ),
              // Right side: Add Icon and Text
              GestureDetector(
                onTap: ()=>{Navigator.push(context, MaterialPageRoute(builder: (_) => const AddHabitPage()))},
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add, // Add icon
                        size: 30,
                        color: Colors.green,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Add Habit',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
      
      ),
    );
  }
}
