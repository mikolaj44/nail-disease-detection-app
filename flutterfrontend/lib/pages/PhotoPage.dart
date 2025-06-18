import 'dart:io';
import 'dart:typed_data';

import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/preanalysis/MLKitUtils.dart';
import 'package:flutter_application_1/pages/MainPage.dart';
import 'package:image/image.dart' as img;


class PhotoPage extends StatelessWidget {
  final String path;

  const PhotoPage(this.path, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.file(File(path)),
        Align(
          alignment: Alignment.bottomCenter,
          child: Text("Pomyślnie wykonano zdjęcie paznokcia.", style: getTextStyle(Colors.black))
        )
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