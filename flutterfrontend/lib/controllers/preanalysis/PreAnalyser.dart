import 'dart:io';

import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/preanalysis/MLKitUtils.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
import 'package:flutter_application_1/structures/triple.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../pages/PhotoPage.dart';

// https://pub.dev/documentation/google_mlkit_object_detection/latest/
class PreAnalyser {

  // https://github.com/flutter-ml/mlkit-custom-model/blob/main/flutter_demo_app/lib/main.dart
  static Future<String> _getAssetPath(String asset) async {
    final path = '${(await getApplicationSupportDirectory()).path}/$asset';
    await Directory(dirname(path)).create(recursive: true);
    final file = File(path);
    if (!await file.exists()) {
      final byteData = await rootBundle.load(asset);
      await file.writeAsBytes(byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    }
    return file.path;
  }

  static Future<Triple<String, double, Rect>> getLabel(AnalysisImage image) async {
    final modelPath = await _getAssetPath("assets/models/lite0.tflite");

    final options = LocalObjectDetectorOptions(modelPath: modelPath, mode: DetectionMode.single, classifyObjects: true, multipleObjects: false);

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