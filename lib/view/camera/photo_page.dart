import 'dart:typed_data';

import 'dart:math' as math;
import 'package:image/image.dart' as img;

import 'package:flutter_application_1/utils/other/dimension_utils.dart';
import 'package:flutter_application_1/view/camera/yolo_result_widget.dart';

import 'package:flutter/material.dart';

class PhotoPage extends StatelessWidget {
  final img.Image image;
  final double angle;

  const PhotoPage({super.key, required this.image, required this.angle});

  @override
  Widget build(BuildContext context) {
      return Stack(
        children: [
          Transform.rotate(
              angle: angle,
              child: Image.memory(
                Uint8List.fromList(img.encodePng(image)),
                fit: BoxFit.contain,
                width: getWidth(context),
                height: getHeight(context),
              ),
            ),

          YOLOResultWidget()
        ]
      );
    }
}