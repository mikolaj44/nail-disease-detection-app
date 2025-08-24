import 'package:ultralytics_yolo/ultralytics_yolo.dart';

class YOLOModelSetup {
  // Model file is located in android/app/src/main/assets (todo: move it so it can be used by both IOS and Android)
  final String modelPath;

  final int imageWidth;             // typically 640
  final int imageHeight;            // typically the same as width

  // Performance
  final double confidenceThreshold; // for showing boxes
  final double iouThreshold;        // for eliminating overlap
  final int numItemsThreshold;
  final int inferenceFrequency;
  final int maxFps;
  final String cameraResolution;    // for example "1080p"

  final bool includeOriginalImage;
  final bool includeProcessingTimeMs;

  const YOLOModelSetup({required this.modelPath, required this.imageWidth, required this.imageHeight, required this.confidenceThreshold, required this.iouThreshold, required this.numItemsThreshold, required this.inferenceFrequency, required this.maxFps, required this.cameraResolution, required this.includeOriginalImage, required this.includeProcessingTimeMs});
}