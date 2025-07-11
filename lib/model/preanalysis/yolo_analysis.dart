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

  List<YOLOResult> currentResults = [];
  List<YOLOResultTrait> currentBestTraits = [];

  YOLOResult? currentBestResult;

  Uint8List currentImage = Uint8List(0);

  Rect detectionRect = Rect.fromLTRB(IMAGE_WIDTH * CENTER_PERCENTAGE, IMAGE_HEIGHT * CENTER_PERCENTAGE, IMAGE_WIDTH * (1.0 - CENTER_PERCENTAGE), IMAGE_HEIGHT * (1.0 - CENTER_PERCENTAGE));

  bool viewHasLoaded = false;

  void init() async {
    yoloViewController = YOLOViewController();

    await yoloViewController.setThresholds(
      confidenceThreshold: CONFIDENCE_THRESHOLD,
      iouThreshold: IOU_THRESHOLD,
      numItemsThreshold: NUM_ITEMS_THRESHOLD,
    );

    currentBestTraits = listCopy(initialTraits);

    for(YOLOResultTrait trait in currentBestTraits){
      trait.setPositive(false);
    }
  }

  void setViewHasLoaded(bool hasLoaded) {
    viewHasLoaded = hasLoaded;
    notifyListeners();
  }

  static List<YOLOResult> streamingResultsToYOLOResults(Map<String, dynamic> streamingResults){
    List<YOLOResult> results = [];

    for(Map<Object?, Object?> streamingResult in streamingResults["detections"]){
      results.add(YOLOResult.fromMap(streamingResult));
    }

    return results;
  }
}