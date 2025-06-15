import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/preanalysis/MLKitUtils.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
import 'package:flutter_application_1/structures/triple.dart';

import '../../pages/PhotoPage.dart';

// https://pub.dev/documentation/google_mlkit_object_detection/latest/
class PreAnalyser {

  static final options = ObjectDetectorOptions(mode: DetectionMode.single, classifyObjects: true, multipleObjects: false);
  //static final options = LocalObjectDetectorOptions(modelPath: "resources/yolov7tiny.tflite", mode: DetectionMode.single, classifyObjects: true, multipleObjects: false);

  static Future<Triple<String, double, Rect>> getLabel(AnalysisImage image) async {
    final inputImage = image.toInputImage();

    final objectDetector = ObjectDetector(options: options);

    final List<DetectedObject> objects = await objectDetector.processImage(inputImage);

    String result = "null";
    Rect resultRect = Rect.zero;
    double resultConfidence = 0;

    print("length: ${objects.length}");

    for(DetectedObject detectedObject in objects){
      final rect = detectedObject.boundingBox;
      final trackingId = detectedObject.trackingId;

      print('rect ${detectedObject.boundingBox}');

      for(Label label in detectedObject.labels){
        result = label.text;
        resultRect = rect;
        resultConfidence = label.confidence;

        print('detected ${label.text} ${label.confidence}');
      }

      objectDetector.close();
    }

    return Triple(result, resultConfidence, resultRect);
  }
}