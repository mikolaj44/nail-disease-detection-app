library;

import 'package:image/image.dart' as img;

import 'dart:typed_data';

import 'package:flutter_application_1/model/preanalysis/yolo_model.dart';
import 'package:ultralytics_yolo/ultralytics_yolo.dart';

part "yolo_detection_model_controller.dart";
part "yolo_classification_model_controller.dart";

abstract class YOLOModelController<ModelDataReturnType> {
  final YOLOModel _yoloModel;

  const YOLOModelController({required YOLOModel yoloModel}) : _yoloModel = yoloModel;

  Future<void> init() async {
    await _yoloModel.init();
  }

  bool hasResults() {
    return _yoloModel.currentResults.isNotEmpty;
  }

  Future<ModelDataReturnType?> processImageBytes(Uint8List inputImageBytes) async {
    await _yoloModel.onImage(inputImageBytes);

    return await postProcessCurrentImageBytes();
  }

  Future<ModelDataReturnType?> postProcessCurrentImageBytes();

  get yoloModel => _yoloModel;
}