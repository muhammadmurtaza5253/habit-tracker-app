
class Helpers {
int calculatePoints(Map? habit) {
  if (habit == null) return 0;

  // Parse the add_date in format dd/mm/yyyy
  String addDateStr = habit['add_date'];
  List<String> dateParts = addDateStr.split('/');
  int day = int.parse(dateParts[0]);
  int month = int.parse(dateParts[1]);
  int year = int.parse(dateParts[2]);

  // Create a DateTime object from the add_date
  DateTime addDate = DateTime(year, month, day);

  // Calculate how many days have passed since add_date
  int daysPassed =
      DateTime.now().difference(addDate).inDays; // Include the current day

  // Extract the track_attendance string
  String trackAttendance = habit['track_attendance'] ?? '';

  // Initialize missed points
  int missedPoints = 0;

  // Loop through the days that have passed
  for (int i = 1; i <= daysPassed && i <= 7; i++) {
    // If the current day number (i) is not in the track_attendance string, it was missed
    if (!trackAttendance.contains(i.toString())) {
      missedPoints++;
    }
  }

  // Return the total missed points
  return missedPoints;
}
}