import 'package:flutter/material.dart';

class WeekCards extends StatelessWidget {
  const WeekCards({super.key});

  // Function to get the current week dates starting from Monday
  List<DateTime> getWeekDates() {
    DateTime now = DateTime.now();
    int currentDayOfWeek = now.weekday;
    DateTime startOfWeek = now.subtract(Duration(days: currentDayOfWeek - 1)); // Get Monday

    return List.generate(7, (index) {
      return startOfWeek.add(Duration(days: index));
    });
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime> weekDates = getWeekDates();
    DateTime today = DateTime.now(); // Get today's date

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: weekDates.map((date) {
            bool isToday = date.year == today.year && date.month == today.month && date.day == today.day;
            return WeekCard(date: date, isToday: isToday); // Pass whether it's today
          }).toList(),
        ),
      ),
    );
  }
}

class WeekCard extends StatelessWidget {
  final DateTime date;
  final bool isToday; // Flag to check if the card is for today

  WeekCard({super.key, required this.date, required this.isToday});

  // List of shortened weekday names (first three letters)
  final List<String> weekdays = [
    'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'
  ];

  @override
  Widget build(BuildContext context) {
    // Get the day and the weekday manually
    String dateString = date.day.toString().padLeft(2, '0'); // Format date as dd
    String weekdayString = weekdays[date.weekday - 1]; // Get the weekday name

    // Calculate the width of the card based on screen width
    double cardWidth = (MediaQuery.of(context).size.width - 90) / 7; // 90px for the padding

    return Card(
      margin: const EdgeInsets.all(3),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: isToday ? Colors.purple : Colors.white, // Highlight today's card
      child: Container(
        padding: EdgeInsets.zero,
        width: cardWidth, // Use the calculated width
        height: 100, // Keep the height fixed
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Align the date number to the center
            SizedBox(
              height: 30,
              child: Text(
                dateString,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isToday ? Colors.white : Colors.black, // Text color change for today's card
                ),
                textAlign: TextAlign.center, // Center align the date
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 18,
              child: Text(
                weekdayString,
                style: TextStyle(
                  fontSize: 12,
                  color: isToday ? Colors.white : Colors.grey, // Text color change for today's card
                ),
                textAlign: TextAlign.center, // Center align the weekday
              ),
            ),
          ],
        ),
      ),
    );
  }
}
