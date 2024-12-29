import 'package:flutter/material.dart';

class CrushingItWidget extends StatelessWidget {
  const CrushingItWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Crushing It",
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          CustomPaint(
            size: Size(200, 40), // Width and height of the arc container
            painter: SmileArcPainter(),
          ),
           Text(
            "Keep it up! You can do it!",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class SmileArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.purple
      ..style = PaintingStyle.fill;

    Path path = Path();

    // Start drawing the arc (a "smiley" shape)
    path.moveTo(0, size.height / 2); // Start point at left middle
    path.quadraticBezierTo(
      size.width / 2, size.height, // Control point: top center of the arc
      size.width, size.height / 2, // End point at right middle
    );

    canvas.drawPath(path, paint); // Draw the path on canvas
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false; // No need to repaint since it's static
  }
}
