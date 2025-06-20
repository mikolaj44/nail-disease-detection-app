import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/preanalysis/YOLOResultInfo.dart';
import 'package:ultralytics_yolo/yolo.dart';
import 'package:ultralytics_yolo/yolo_streaming_config.dart';
import 'package:ultralytics_yolo/yolo_view.dart';
import 'package:provider/provider.dart';

import '../../pages/MainPage.dart';

// Model-dependent
const String MODEL_NAME = "yolov8n 40e 640 float16"; // Located in android/app/assets/ (todo: move it so it can be used by both IOS and Android)
const int MODEL_IMAGE_WIDTH = 640;

// Debug
const bool DO_DEBUG_PRINT = false;

// Nail detection info
const double MIN_NAIL_THRESHOLD = 0.7;

// Performance
const double CONFIDENCE_THRESHOLD = 0.5;
const double IOU_THRESHOLD = 0.4;
const int NUM_ITEMS_THRESHOLD = 5;
const int INFERENCE_FREQUENCY = 10;
const int MAX_FPS = 15;
const String CAMERA_RESOLUTION = "1080p";

// Ex. start from 30% of image length from all borders
const double CENTER_PERCENTAGE = 0.3;

// Minimal and maximal size of the nail rect
const double MIN_WIDTH_PERCENTAGE = 0.3;
const double MAX_WIDTH_PERCENTAGE = 0.6;

// Minimum score for an image to be considered valid for further analysis
final int MIN_VALID_SCORE = IS_NAIL.score + IS_IN_BOUNDS.score + IS_CORRECT_SIZE.score;

final List<YOLOResultTrait> initialTraits = [IS_NAIL.copy(), IS_IN_BOUNDS.copy(), IS_CORRECT_SIZE.copy()];

final YOLOAnalysis yoloAnalysis = YOLOAnalysis();

class YOLOAnalysis with ChangeNotifier {
  late YOLO yolo;
  late YOLOViewController controller;

  List<YOLOResult> currentResults = [];
  List<YOLOResultTrait> bestTraits = [];

  Uint8List currentImage = Uint8List(0);

  Rect detectionRect = Rect.fromLTRB(MODEL_IMAGE_WIDTH * CENTER_PERCENTAGE, MODEL_IMAGE_WIDTH * CENTER_PERCENTAGE, MODEL_IMAGE_WIDTH * (1.0 - CENTER_PERCENTAGE), MODEL_IMAGE_WIDTH * (1.0 - CENTER_PERCENTAGE));

  void initModel() async {
    controller = YOLOViewController();

    await controller.setThresholds(
      confidenceThreshold: CONFIDENCE_THRESHOLD,    // High confidence only
      iouThreshold: IOU_THRESHOLD,                  // Fast NMS
      numItemsThreshold: NUM_ITEMS_THRESHOLD,       // Minimal detections
    );

    bestTraits = initialTraits;

    for(YOLOResultTrait trait in bestTraits){
      trait.setPositive(false);
    }
  }

  bool resultIsValid(){
    int score = 0;

    for(YOLOResultTrait trait in bestTraits){
      score += trait.score;
    }

    return score >= MIN_VALID_SCORE;
  }

  Uint8List getCurrentImageData(){
    return currentImage;
  }

  void updateBestTraits() {
    bestTraits = YOLOResultInfo.getBestYOLOResultTraits(initialTraits, currentResults, MIN_NAIL_THRESHOLD, detectionRect);
    notifyListeners();
  }
}

class YOLOPage extends StatefulWidget {
  @override
  YOLOPageState createState() => YOLOPageState();
}

class YOLOPageState extends State<YOLOPage> {
  @override
  void initState() {
    super.initState();
  }

  List<YOLOResult> streamingResultsToYOLOResults(Map<String, dynamic> streamingResults){
    List<YOLOResult> results = [];

    for(Map<Object?, Object?> streamingResult in streamingResults["detections"]){
     results.add(YOLOResult.fromMap(streamingResult));
    }

    return results;
  }

  // https://github.com/ultralytics/yolo-flutter-app/blob/main/doc/usage.md#real-time-camera-processing
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          YOLOView(
            modelPath: MODEL_NAME,
            task: YOLOTask.detect,
            controller: yoloAnalysis.controller,
            cameraResolution: CAMERA_RESOLUTION,

            streamingConfig: YOLOStreamingConfig.custom(
              inferenceFrequency: INFERENCE_FREQUENCY,    // 15 FPS inference
              maxFPS: MAX_FPS,               // 10 FPS display
              includeOriginalImage: true,
              includeDetections: true,
            ),

            onStreamingData: (streamData) {
              setState(() {
                print("streaming data");
                if (streamData.containsKey("detections") && streamData["detections"] != null) {
                  yoloAnalysis.currentResults = streamingResultsToYOLOResults(streamData);
                  yoloAnalysis.updateBestTraits();
                }

                if (streamData.containsKey("originalImage") && streamData["originalImage"] != null) {
                  yoloAnalysis.currentImage = streamData["originalImage"] as Uint8List;
                }
              });
            },

              // This doesn't actually run if onStreamingData is provided, but removing onResult breaks the output
              onResult: (results) {
                setState(() {
                  yoloAnalysis.currentResults = results;
                });
              }

            //key: const ValueKey('yolo_view'),
          ),
        ]
      ),
    );
  }
}

class NailOutlineWidget extends StatelessWidget{
  const NailOutlineWidget({super.key});

  @override
  Widget build(BuildContext context){
    return Center(
        child: Stack(
            children: [
              Center(
                child: Opacity(
                  opacity: 0.7,
                  child: ImageIcon(
                    AssetImage("resources/nailoutline.png"),
                    size: screenWidth / 2.5,
                  ),
                ),
              ),
              Center(
                child: Opacity(
                  opacity: 0.3,
                  child: Icon(
                    Icons.square_rounded,
                    size: screenWidth / 1.2,
                  ),
                ),
              ),
            ]
        )
    );
  }
}