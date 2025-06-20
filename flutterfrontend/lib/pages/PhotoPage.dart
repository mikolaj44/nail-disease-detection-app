import 'dart:io';
import 'dart:typed_data';

import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/MainPage.dart';
import 'package:image/image.dart' as img;


class PhotoPage extends StatelessWidget {
  final Uint8List imageData;

  const PhotoPage(this.imageData, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.memory(imageData),
        Align(
          alignment: Alignment.bottomCenter,
          child: Text("Pomyślnie wykonano zdjęcie paznokcia.", style: getTextStyle(Colors.black))
        )
      ]
    );
  }
}