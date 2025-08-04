import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:ultralytics_yolo/ultralytics_yolo.dart';

class YOLOHelpers {
  static List<YOLOResult> resultsToYOLOResults(Map<String, dynamic> results, {required bool isFromStream}){
    List<YOLOResult> yoloResults = [];

    String resultContainerName = isFromStream ? "detections" : "boxes";

    for(Map<Object?, Object?> result in results[resultContainerName]){
      if(isFromStream) {
        yoloResults.add(YOLOResult.fromMap(result));
      }
      else{
        yoloResults.add(yoloResultFromSingleImageResult(result));
      }
    }

    return yoloResults;
  }

  static YOLOResult yoloResultFromSingleImageResult(Map<dynamic, dynamic> map) {
    final className = map['class'] as String;
    final confidence = (map['confidence'] as num).toDouble();

    final boundingBox = Rect.fromLTRB(
      (map['x1'] as num).toDouble(),
      (map['y1'] as num).toDouble(),
      (map['x2'] as num).toDouble(),
      (map['y2'] as num).toDouble(),
    );

    return YOLOResult(
        classIndex: 0,
        className: className,
        confidence: confidence,
        boundingBox: boundingBox,
        normalizedBox: Rect.zero
    );
  }
}