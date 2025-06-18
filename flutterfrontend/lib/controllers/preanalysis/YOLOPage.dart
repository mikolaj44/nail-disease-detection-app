import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/MainPage.dart';
import 'package:ultralytics_yolo/yolo.dart';
import 'package:ultralytics_yolo/yolo_streaming_config.dart';
import 'package:ultralytics_yolo/yolo_view.dart';

import '../../pages/PhotoPage.dart';
import '../../structures/pair.dart';
import '../../structures/triple.dart';

const bool DO_DEBUG_PRINT = false;
const double MIN_THRESHOLD = 0.7;

const int MODEL_IMAGE_WIDTH = 640;
const double CENTER_PERCENTAGE = 0.3;

// https://github.com/ultralytics/yolo-flutter-app/blob/main/doc/usage.md#multi-instance-support
class YOLOPage extends StatefulWidget {
  @override
  YOLOPageState createState() => YOLOPageState();
}

class YOLOPageState extends State<YOLOPage> {
  static late YOLO yolo;
  static late YOLOViewController controller;

  static List<YOLOResult> currentResults = [];

  static late Rect detectionRect;

  Triple<IconData, String, Color> resultInfo = Triple(Icons.abc, "", Colors.transparent);

  @override
  void initState() {
    super.initState();

    detectionRect = Rect.fromLTRB(MODEL_IMAGE_WIDTH * CENTER_PERCENTAGE, MODEL_IMAGE_WIDTH * CENTER_PERCENTAGE, MODEL_IMAGE_WIDTH * (1.0 - CENTER_PERCENTAGE), MODEL_IMAGE_WIDTH * (1.0 - CENTER_PERCENTAGE));
  }

  static void initModel() async {
    controller = YOLOViewController();

    await controller.setThresholds(
      confidenceThreshold: 0.5,    // High confidence only
      iouThreshold: 0.4,           // Fast NMS
      numItemsThreshold: 5,        // Minimal detections
    );

    final config = YOLOStreamingConfig.powerSaving(
      inferenceFrequency: 10,    // 5 FPS inference
      maxFPS: 15,               // 10 FPS display
    );

    controller.setStreamingConfig(config);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Camera view with YOLO processing
          YOLOView(
            modelPath: "yolov8n 40e 640 float16",
            task: YOLOTask.detect,
            controller: controller,
            cameraResolution: "1080p",

            onResult: (results) {
              setState(() {
                currentResults = results;
                resultInfo = getYOLOResultInfoPair(results);
              });
            },

            onPerformanceMetrics: (metrics) {
              if(DO_DEBUG_PRINT) {
                print('FPS: ${metrics.fps.toStringAsFixed(1)}');
                print('Processing time: ${metrics.processingTimeMs.toStringAsFixed(1)}ms');
              }
            },
          ),

          // Overlay UI
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: screenHeight * 0.02),
              child: Container(
                decoration: BoxDecoration(color: resultInfo.c, borderRadius: BorderRadius.circular(16)),
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    if(resultInfo.a != Icons.abc)
                      Icon(
                          resultInfo.a,
                          size: screenWidth / 5
                      ),

                    SizedBox(width: 10),
                    Text(
                      resultInfo.b,
                      style: getTextStyle(Colors.black),
                    )
                  ],
                ),
              ),
            )
            ),
        ],
      ),
    );
  }

  static Triple<IconData, String, Color> getYOLOResultInfoPair(List<YOLOResult> results){
    for(YOLOResult result in results) {
      print("main $detectionRect");
      print("rect ${result.boundingBox}");

      if (result.confidence >= MIN_THRESHOLD && detectionRect.contains(result.boundingBox.center)) {
        return Triple(Icons.check_circle_rounded, "Wykryto paznokieć!", Colors.green);
      }
    }
    return Triple(Icons.error_rounded, "Nie wykryto paznokcia.", Colors.red);
  }

  static bool resultIsValid(){
    return getYOLOResultInfoPair(currentResults).c == Colors.green;
  }
}