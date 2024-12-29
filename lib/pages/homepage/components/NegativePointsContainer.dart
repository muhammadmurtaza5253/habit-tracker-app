import 'package:flutter/material.dart';
import 'package:habit_tracker_app/utils/image_urls.dart';

class NegativePointsContainer extends StatelessWidget {
  const NegativePointsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity, // Takes up full width of the parent container
        height: 150, // Fixed height of 200
        decoration: BoxDecoration(
          color: Colors.red.shade50, // Light red background color
          borderRadius: BorderRadius.circular(15), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4), // Shadow offset
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment
                .spaceBetween, // Align items to the left and right
            children: [
              const SizedBox(
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Look out, you are getting negative points!',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '-20', // Hardcoded negative points
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
              ),
          
              // Right side: Image
              Image.asset(ImageUrls.alertImage)
            ],
          ),
        ),
    );
  }
}
