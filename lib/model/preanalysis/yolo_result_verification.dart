import 'dart:typed_data' as td;

import 'package:ultralytics_yolo/yolo.dart';

import '../../controller/image_analysis/image_analysis_controller.dart';
import '../../utils/image_methods.dart';
import '../../model/preanalysis/yolo_constants.dart';

enum ImageDetectionIssue {
  tooDark,
  noDetections,
  multipleDetections,
  noIssues
}

class YOLOResultVerification {
  static ImageDetectionIssue getDetectionIssue({required List<YOLOResult> results, required td.Uint8List detectionImage}){
    if(getImageBrightness(detectionImage) < MIN_BRIGHTNESS){
      return ImageDetectionIssue.tooDark;
    }

    List<YOLOResult> validResults = [];

    for(YOLOResult result in results){
      if(result.confidence >= CONFIDENCE_THRESHOLD){
        validResults.add(result);
      }
    }

    if(validResults.isEmpty){
      return ImageDetectionIssue.noDetections;
    }

    if(validResults.length > 1){
      return ImageDetectionIssue.multipleDetections;
    }

    return ImageDetectionIssue.noIssues;
  }
}