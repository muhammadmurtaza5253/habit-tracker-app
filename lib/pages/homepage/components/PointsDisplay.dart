import 'package:flutter/material.dart';

class PointsDisplay extends StatelessWidget {
  final int positivePoints;
  final int negativePoints;

  PointsDisplay({required this.positivePoints, required this.negativePoints});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // Circular border radius
      ),
      elevation: 5, // Optional: Adds shadow for card effect
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purple.shade700, // Dark purple color
              Colors.purple.shade400, // Lighter purple color
            ],
            begin: Alignment.topLeft, // Start of the gradient
            end: Alignment.bottomRight, // End of the gradient
          ),
          borderRadius: BorderRadius.circular(16), // Circular border for gradient
        ),
        padding: const EdgeInsets.all(16), // Padding inside the card
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Positive Points Column
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Positive Points',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '$positivePoints',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            
            // Divider
      Container(
              width: 1, // Width of the divider
              height: 70, // Height of the divider (adjust as necessary)
              color: Colors.white, // Color of the divider
            ),
            // Negative Points Column
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Negative Points',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '$negativePoints',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
