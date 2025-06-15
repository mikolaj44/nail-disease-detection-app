import 'dart:io';

import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/preanalysis/MLKitUtils.dart';

class PhotoPage extends StatelessWidget {
  final String imagePath;
  final String label;
  final double confidence;
  final Rect rect;

  const PhotoPage(this.imagePath, this.label, this.confidence, this.rect, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.file(File(imagePath)),
        CustomPaint(
        painter: RectPainter(rect),
        child: SizedBox.expand(), // Center(child: Text(label))
      ),
    ]
    );
  }
}

class RectPainter extends CustomPainter {
  Rect rect;

  RectPainter(this.rect);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}