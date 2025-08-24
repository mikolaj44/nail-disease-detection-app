part of "yolo_model.dart";

class YOLOClassificationModel extends YOLOModel {
  YOLOClassificationModel({required super.yoloModelSetup});

  @override
  void _onStreamData(Map<String, dynamic> streamData){
    throw UnsupportedError("Classification is only for static images.");
  }

  @override
  Future<void> onImageFromGallery(td.Uint8List imageBytes) async {
    final results = await _yolo.predict(imageBytes);

    print(results['classifications']);
    print(results);

    // Process classification results
    final classifications = results['classifications'] as List<dynamic>? ?? [];
    for (final classification in classifications) {
      print('Class: ${classification['class']}');
      print('Confidence: ${classification['confidence']}');
    }

    print("after classification");

    // if(results.containsKey("boxes")) {
    //   _currentResults = _resultsToYOLOResults(results, isFromStream: false);
    // }
    // else {
    //   _currentResults = [];
    // }
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