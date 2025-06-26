import 'dart:typed_data';

import 'dart:math' as math;
import 'package:image/image.dart' as img;

import 'package:flutter_application_1/utils/other/dimension_utils.dart';
import 'package:flutter_application_1/view/camera/yolo_result_widget.dart';

import 'package:flutter/material.dart';

class PhotoPage extends StatelessWidget {
  final img.Image image;

  const PhotoPage(this.image, {super.key});

  @override
  Widget build(BuildContext context) {
      return Stack(
        children: [
          Transform.rotate(
              angle: math.pi / 2,
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

    // return Stack(
    //   children: [
    //     Transform.rotate(
    //         angle: math.pi / 2,
    //         child: Image.memory(imageData)
    //     ),
    //     Align(
    //       alignment: Alignment.bottomCenter,
    //       child: Text("Pomyślnie wykonano zdjęcie paznokcia.", style: getTextStyle(Colors.black))
    //     )
    //   ]
    // );
  //}
}