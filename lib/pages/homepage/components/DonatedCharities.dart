import 'package:flutter/material.dart';

class DonatedCharitiesSection extends StatelessWidget {
  const DonatedCharitiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Section
          const Text(
            'You have donated to',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),

          // Horizontal Scroll for Charity Logos
          SizedBox(
            height: 100, // Height of the logo section
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 8,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.purple.shade700, // Dark purple color
                              Colors.purple.shade400, // Lighter purple color
                            ],
                            begin: Alignment.topLeft, // Start of the gradient
                            end: Alignment.bottomRight, // End of the gradient
                          ),
                          borderRadius:
                              BorderRadius.circular(8), // Rounded corners
                        ),
                      )),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
