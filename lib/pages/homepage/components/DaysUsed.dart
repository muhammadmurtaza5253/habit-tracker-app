import 'package:flutter/material.dart';

class DaysUsed extends StatelessWidget {
  // Hardcoded number of days
  final int days = 25;

  const DaysUsed({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Text on the left
          const SizedBox(
            width: 180,
            child: Text(
              'You have been using this app for',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 10), // Space between text and divider
          // Divider in the middle
          const VerticalDivider(
            color: Colors.black,
            thickness: 1,
            width: 20,
          ),
          const SizedBox(width: 10), // Space between divider and days number
          // Number of days on the right
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), // Padding inside container
            decoration: BoxDecoration(
              color: Colors.purple, // Purple background color
              borderRadius: BorderRadius.circular(15), // Circular border radius
            ),
            child: Text(
              '$days days',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white, // White text color
              ),
            ),)
        ],
      ),
    );
  }
}
