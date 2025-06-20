import 'dart:async';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/MainPage.dart';

class PhotoPage extends StatelessWidget {
  final Uint8List imageData;

  const PhotoPage(this.imageData, {super.key});

  @override
  Widget build(BuildContext context) {
    final Completer<ui.Image> completer = Completer();

    ui.decodeImageFromList(imageData, (ui.Image img) {
      completer.complete(img);
      print("width: ${img.width}, height: ${img.height}");
    });

    return Transform.rotate(
      angle: math.pi / 2,
      child: Image.memory(
        imageData,
        fit: BoxFit.fitWidth,
        width: screenWidth,
        height: screenHeight,
      ),
    );
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
  }
}