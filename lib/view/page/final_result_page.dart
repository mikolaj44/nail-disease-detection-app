import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_application_1/utils/dimension_utils.dart';
import 'package:flutter/material.dart';

import 'dart:typed_data';

import 'package:flutter_application_1/utils/style_methods.dart';

class FinalResultPage extends StatelessWidget {
  final Uint8List imageBytes;
  final double angle;

  final String diseaseName;
  final double confidence;

  const FinalResultPage({super.key, required this.imageBytes, required this.angle, required this.confidence, required this.diseaseName});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/waves.png"),
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                AspectRatio(
                                  aspectRatio: 1.0,
                                  child: Transform.rotate(
                                        angle: angle,
                                        child: Image.memory(
                                          imageBytes,
                                          fit: BoxFit.fitWidth,
                                        ),
                                    ),
                                ),
                                Container(
                                  height: getHeight(context) * 0.15,
                                  width: getWidth(context) * 0.5,
                                  decoration: BoxDecoration(
                                    color: Colors.lightGreen,
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: AutoSizeText(
                                      "$diseaseName\n${(confidence * 100).toStringAsFixed(2)}%",
                                      style: getTextStyle(context, Colors.black, fontSize: 99999),
                                  ),
                                )

                                // YOLOResultWidget()
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