import 'package:flutter/material.dart';

// Custom Button Widget
class GradientButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonName;

  const GradientButton({
    super.key,
    required this.onPressed,
    required this.buttonName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.purple.shade700, // Dark purple color
            Colors.purple.shade400, // Lighter purple color
          ],
          begin: Alignment.topLeft, // Start of the gradient
          end: Alignment.bottomRight, // End of the gradient
        ),
        borderRadius: BorderRadius.circular(8), // Rounded corners
      ),
      child: ElevatedButton(
        onPressed: onPressed, // Action passed from parent
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent, // Make the button background transparent
          shadowColor: Colors.transparent, // Optional: Removes shadow if any
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Ensure rounded corners
          ),
        ),
        child: Center(
          child: Text(
            buttonName, // The button's text passed from parent
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white, // Text color
            ),
          ),
        ),
      ),
    );
  }
}
