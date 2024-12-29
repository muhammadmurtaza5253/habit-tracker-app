import 'package:flutter/material.dart';

class QuoteDialog extends StatelessWidget {
  final String quote;
  final String author;

  const QuoteDialog({super.key, required this.quote, required this.author});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Close button (cross) at the top right
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.close, size: 30, color: Colors.black),
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
            ),
          ),
          // Motivational Quote
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              '"$quote"',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          Text(
            '- $author',
            style: const TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
