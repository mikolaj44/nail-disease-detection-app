import 'dart:async';
import 'dart:typed_data';

import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter_application_1/controllers/preanalysis/YOLOResultInfo.dart';
import 'package:image/image.dart' as img;

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/MainPage.dart';
import 'package:provider/provider.dart';

import '../controllers/preanalysis/YOLOPage.dart';

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
                width: screenWidth,
                height: screenHeight,
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