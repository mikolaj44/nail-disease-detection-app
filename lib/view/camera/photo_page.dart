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
    return SafeArea(
      child:
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("resources/waves.png"),
            fit: BoxFit.cover,
          ),
        ),
        child:
        Align(
          alignment: Alignment.center,
          child: Card(
              elevation: 20,
              child:
              Container(
                height: getHeight(context) * 0.9,
                width: getWidth(context) * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 0, 0, 0),
                      Color.fromARGB(255, 61, 61, 61)
                    ],
                    begin: Alignment.topCenter,
                  ),
                ),

                child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getWidth(context) * 0.05,
                          vertical: getHeight(context) * 0.05,
                        ),
                      child: Align(
                          alignment: Alignment.center,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Transform.rotate(
                                  angle: angle,
                                  child: Image.memory(
                                    Uint8List.fromList(
                                        img.encodePng(image)),
                                        fit: BoxFit.fitWidth,
                                  ),
                                ),

                                YOLOResultWidget()
                              ]
                          )
                        ),
                    )
                ),
              )
          ),
        ),
      ),
    );
  }
}