part of "yolo_model.dart";

class YOLODetectionModel extends YOLOModel {
  YOLODetectionModel({required super.yoloModelSetup});

  @override
  void _onStreamData(Map<String, dynamic> streamData){
    if (streamData.containsKey("detections") && streamData["detections"] != null) {
      _currentResults = _resultsToYOLOResults(streamData, isFromStream: true);
    }
    else {
      _currentResults = [];
    }

    if (streamData.containsKey("originalImage") && streamData["originalImage"] != null) {
      _currentImage = streamData["originalImage"] as td.Uint8List;
    }
  }

  @override
  Future<void> onImageFromGallery(td.Uint8List imageBytes) async {
    final results = await _yolo.predict(imageBytes);

    if(results.containsKey("boxes")) {
      _currentResults = _resultsToYOLOResults(results, isFromStream: false);
    }
    else {
      _currentResults = [];
    }

    _currentAnnotatedImage = results["annotatedImage"] as td.Uint8List;
    _currentImage = imageBytes;
  }

  @override
  YOLOTask getYOLOTask() {
    return YOLOTask.detect;
  }

  @override
  bool _includeDetections() {
    return true;
  }

  @override
  bool _includeClassifications() {
    return false;
  }

  List<YOLOResult> _resultsToYOLOResults(Map<String, dynamic> results, {required bool isFromStream}){
    List<YOLOResult> yoloResults = [];

    String resultContainerName = isFromStream ? "detections" : "boxes";

    for(Map<Object?, Object?> result in results[resultContainerName]){
      if(isFromStream) {
        yoloResults.add(YOLOResult.fromMap(result));
      }
      else{
        yoloResults.add(_yoloResultFromSingleImageResult(result));
      }
    }

    return yoloResults;
  }

  YOLOResult _yoloResultFromSingleImageResult(Map<dynamic, dynamic> map) {
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