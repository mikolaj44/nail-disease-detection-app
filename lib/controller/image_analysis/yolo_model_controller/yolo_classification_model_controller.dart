part of "yolo_model_controller.dart";

class YoloClassificationModelController extends YOLOModelController<YOLOResult> {
  const YoloClassificationModelController({required super.yoloModel});

  @override
  Future<YOLOResult?> postProcessCurrentImageBytes() async {
    return _yoloModel.currentResults.first;
  }
}