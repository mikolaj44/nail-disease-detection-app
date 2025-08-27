import 'dart:typed_data' as td;

import 'package:flutter_application_1/main.dart';
import 'package:ultralytics_yolo/yolo.dart';

import '../../utils/image_methods.dart';

enum ImageDetectionIssue {
  tooDark,
  noDetections,
  multipleDetections,
  noIssues,
}

ImageDetectionIssue getDetectionIssue({required List<YOLOResult> results, required td.Uint8List detectionImage}) {
  if (getImageBrightness(detectionImage) < minBrightness) {
    return ImageDetectionIssue.tooDark;
  }

  List<YOLOResult> validResults = [];

  for (YOLOResult result in results) {
    if (result.confidence >= confidenceThreshold) {
      validResults.add(result);
    }
  }

  if (validResults.isEmpty) {
    return ImageDetectionIssue.noDetections;
  }

  if (validResults.length > 1) {
    return ImageDetectionIssue.multipleDetections;
  }

  return ImageDetectionIssue.noIssues;
}