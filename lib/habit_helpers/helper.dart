import 'package:shared_preferences/shared_preferences.dart';

class Helper {
  String? currentWeek;
  late SharedPreferences prefs;

  Helper() {
    _initializeSharedPreference();
  }

  Future<void> _initializeSharedPreference() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<String> fetchCurrentWeek() async {
    await _initializeSharedPreference();
    return prefs.getString('currentWeek') ?? '';
  }

  Future<void> saveCurrentWeek(String week) async {
    await _initializeSharedPreference();
    await prefs.setString('currentWeek', week);
  }

  String getOrdinalSuffix(int number) {
    if (number >= 10 && number <= 20) {
      return '${number}th';
    }

    switch (number % 10) {
      case 1:
        return '${number}st';
      case 2:
        return '${number}nd';
      case 3:
        return '${number}rd';
      default:
        return '${number}th';
    }
  }

  getCurrentWeek() {
    //Get the current data
    DateTime now = DateTime.now();
    DateTime firstDay = DateTime(now.year, now.month, 1);
    int differenceInDays = now.difference(firstDay).inDays;
    int weekNumber = (differenceInDays / 7).floor();
    if (weekNumber > 3) {
      return '';
    }
    //now calculate the week range
    DateTime weekStart = firstDay.add(Duration(days: weekNumber * 7));
    DateTime weekEnd = firstDay.add(Duration(days: (weekNumber + 1) * 7 - 1));

    // Ensure the end date does not go beyond the last day of the month
    if (weekEnd.month != now.month) {
      return ''; // Week goes beyond the current month
    }
    String startDay = weekStart.day.toString();
    String endDay = weekEnd.day.toString();

    // Return the formatted string as "start date - end date"
    return '$startDay- $endDay';
  }

  String getCurrentWeekText() {
    String currentWeekDays = getCurrentWeek();
    String startDay = currentWeekDays.split('-')[0];
    String endDay = currentWeekDays.split('-')[1];
    return 'Follow the habit for ${getOrdinalSuffix(int.parse(startDay))} - ${getOrdinalSuffix(int.parse(endDay))}';
  }

  String getCurrentMonth() {
    DateTime now = DateTime.now();
    List<String> monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    return monthNames[now.month - 1];
  }
}
