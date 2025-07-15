import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/preanalysis/yolo_constants.dart';
import 'package:flutter_application_1/model/preanalysis/yolo_result_preprocessing.dart';
import 'package:ultralytics_yolo/yolo.dart';
import 'package:ultralytics_yolo/yolo_streaming_config.dart';
import 'package:ultralytics_yolo/yolo_view.dart';
import 'package:provider/provider.dart';

import 'package:image/image.dart' as img;

import '../../utils/other/list_copy.dart';

class YOLOAnalysis with ChangeNotifier {
  late YOLO yolo;
  late YOLOViewController yoloViewController;
  late YOLOStreamingConfig yoloStreamingConfig;

  List<YOLOResult> currentResults = [];
  Uint8List currentImage = Uint8List(0);

  List<YOLOResultTrait> currentBestTraits = [];
  YOLOResult? currentBestResult;

  bool viewHasLoaded = false;

  void init() async {
    yoloViewController = YOLOViewController();

    yoloStreamingConfig = YOLOStreamingConfig.custom(
      inferenceFrequency: INFERENCE_FREQUENCY,
      maxFPS: MAX_FPS,
      includeOriginalImage: true,
      includeDetections: true,
    );

    await yoloViewController.setThresholds(
      confidenceThreshold: CONFIDENCE_THRESHOLD,
      iouThreshold: IOU_THRESHOLD,
      numItemsThreshold: NUM_ITEMS_THRESHOLD,
    );

    yolo = YOLO(
      modelPath: MODEL_NAME,
      task: YOLOTask.detect,
    );

    await yolo.loadModel();

    currentBestTraits = listCopy(initialTraits);

    for(YOLOResultTrait trait in currentBestTraits){
      trait.setPositive(false);
    }
  }

  void setViewHasLoaded(bool hasLoaded) {
    viewHasLoaded = hasLoaded;
    notifyListeners();
  }

  static List<YOLOResult> resultsToYOLOResults(Map<String, dynamic> results, {required bool isFromStream}){
    List<YOLOResult> yoloResults = [];

    String resultContainerName = isFromStream ? "detections" : "boxes";

    for(Map<Object?, Object?> result in results[resultContainerName]){
      //print("yolo result: ${result}");
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