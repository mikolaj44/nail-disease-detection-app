library;

import 'dart:typed_data' as td;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/preanalysis/yolo_model_setup.dart';
import 'package:ultralytics_yolo/yolo.dart';
import 'package:ultralytics_yolo/yolo_streaming_config.dart';
import 'package:ultralytics_yolo/yolo_view.dart';

part "yolo_detection_model.dart";
part "yolo_classification_model.dart";

abstract class YOLOModel with ChangeNotifier {
  final YOLOModelSetup _yoloModelSetup;

  late YOLO _yolo;
  late YOLOViewController _yoloViewController;
  late YOLOStreamingConfig _yoloStreamingConfig;

  bool _viewHasLoaded = false;

  List<YOLOResult> _currentResults = [];
  Uint8List _currentImage = Uint8List(0);
  Uint8List _currentAnnotatedImage = Uint8List(0);

  YOLOModel({required YOLOModelSetup yoloModelSetup}) : _yoloModelSetup = yoloModelSetup;

  @nonVirtual
  Future<void> init() async {
    _yoloViewController = YOLOViewController();

    _yoloStreamingConfig = YOLOStreamingConfig.custom(
      inferenceFrequency: yoloModelSetup.inferenceFrequency,
      maxFPS: yoloModelSetup.maxFps,
      includeOriginalImage: yoloModelSetup.includeOriginalImage,
      includeDetections: _includeDetections(),
      includeClassifications: _includeClassifications(),
      includeProcessingTimeMs: yoloModelSetup.includeProcessingTimeMs,
    );

    await _yoloViewController.setThresholds(
      confidenceThreshold: yoloModelSetup.confidenceThreshold,
      iouThreshold: yoloModelSetup.iouThreshold,
      numItemsThreshold: yoloModelSetup.numItemsThreshold,
    );

    _yolo = YOLO(
      modelPath: yoloModelSetup.modelPath,
      task: getYOLOTask(),
    );

    await _yolo.loadModel();
  }

  bool get viewHasLoaded => _viewHasLoaded;

  YOLOModelSetup get yoloModelSetup => _yoloModelSetup;

  YOLOViewController get yoloViewController => _yoloViewController;
  YOLOStreamingConfig get yoloStreamingConfig => _yoloStreamingConfig;

  List<YOLOResult> get currentResults => _currentResults;
  Uint8List get currentImage => _currentImage;
  Uint8List get currentAnnotatedImage => _currentAnnotatedImage;

  bool _includeDetections();

  bool _includeClassifications();

  YOLOTask getYOLOTask();

  @nonVirtual
  void onStreamData(Map<String, dynamic> streamData) {
    if(_viewHasLoaded == false) {
      _viewHasLoaded = true;
      notifyListeners();
    }
    _onStreamData(streamData);
  }

  // Updates the current results and image from stream data (live view)
  void _onStreamData(Map<String, dynamic> streamData);

  // Updates the current results and image from image data (sending a photo from gallery)
  Future<void> onImageFromGallery(td.Uint8List imageBytes);
}