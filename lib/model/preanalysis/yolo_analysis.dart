import 'dart:typed_data';
import 'dart:typed_data' as td;

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/preanalysis/yolo_constants.dart';
import 'package:flutter_application_1/model/preanalysis/yolo_helpers.dart';
import 'package:ultralytics_yolo/yolo.dart';
import 'package:ultralytics_yolo/yolo_streaming_config.dart';
import 'package:ultralytics_yolo/yolo_view.dart';

class YOLOAnalysis with ChangeNotifier {
  late YOLO yolo;
  late YOLOViewController yoloViewController;
  late YOLOStreamingConfig yoloStreamingConfig;

  List<YOLOResult> currentResults = [];
  Uint8List currentImage = Uint8List(0);
  Uint8List currentAnnotatedImage = Uint8List(0);

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
  }

  // Updates the current results and image from stream data (live view)
  void onStreamData(Map<String, dynamic> streamData){
    setViewToLoaded();

    if (streamData.containsKey("detections") && streamData["detections"] != null) {
      currentResults = YOLOHelpers.resultsToYOLOResults(streamData, isFromStream: true);
    }
    else {
      currentResults = [];
    }

    if (streamData.containsKey("originalImage") && streamData["originalImage"] != null) {
      currentImage = streamData["originalImage"] as td.Uint8List;
    }
  }

  // Updates the current results and image from image data (sending a photo from gallery)
  Future<void> onImageFromGallery(td.Uint8List imageBytes) async {
    final results = await yolo.predict(imageBytes);

    if(results.containsKey("boxes")) {
      currentResults = YOLOHelpers.resultsToYOLOResults(results, isFromStream: false);
    }
    else {
      currentResults = [];
    }

    currentAnnotatedImage = results["annotatedImage"] as td.Uint8List;
    currentImage = imageBytes;
  }

  void setViewToLoaded() {
    if(!viewHasLoaded){
      notifyListeners();
    }
    viewHasLoaded = true;
  }
}