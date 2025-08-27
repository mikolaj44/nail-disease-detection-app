part of "yolo_model.dart";

class YOLOClassificationModel extends YOLOModel {
  YOLOClassificationModel({required super.yoloModelSetup});

  @override
  void _onStreamData(Map<String, dynamic> streamData){
    throw UnsupportedError("Classification is only for static images.");
  }

  @override
  Future<void> onImage(td.Uint8List imageBytes) async {
    final results = await _yolo.predict(imageBytes);

    if(results.containsKey("detections")) {
      _currentResults = _resultsToYOLOResults(results);
    }
    else {
      _currentResults = [];
    }
  }

  List<YOLOResult> _resultsToYOLOResults(Map<String, dynamic> results){
    List<YOLOResult> yoloResults = [];

    for(Map<Object?, Object?> result in results["detections"]){
      yoloResults.add(YOLOResult.fromMap(result));
    }

    return yoloResults;
  }

  @override
  YOLOTask getYOLOTask() {
    return YOLOTask.classify;
  }

  @override
  bool _includeDetections() {
    return true;
  }

  @override
  bool _includeClassifications() {
    return true;
  }
}