import 'dart:io';
import 'dart:typed_data' as td;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/view/loading/yolo_loading_page.dart';
import 'package:image/image.dart' as img;

import 'dart:ui';
import 'dart:ui';

import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter_application_1/view/camera/camera_page.dart';
import 'package:ultralytics_yolo/ultralytics_yolo.dart';

import '../../model/preanalysis/yolo_analysis.dart';
import '../../model/preanalysis/yolo_result_preprocessing.dart';
import '../../model/preanalysis/yolo_result_preprocessing.dart';
import '../../utils/other/style/style_methods.dart';
import '../../view/camera/photo_page.dart';

final YOLOAnalysis yoloAnalysis = YOLOAnalysis();

class PreAnalysisController {
  td.Uint8List? imageBytes;

  // Initializes the model
  Future<void> init() async {
    yoloAnalysis.init();
  }

  // Updates the current results
  void onStreamData(Map<String, dynamic> streamData){
    yoloAnalysis.setViewHasLoaded(true);

    if (streamData.containsKey("detections") && streamData["detections"] != null) {
      yoloAnalysis.currentResults = YOLOAnalysis.resultsToYOLOResults(streamData, isFromStream: true);
    }

    if (streamData.containsKey("originalImage") && streamData["originalImage"] != null) {
      yoloAnalysis.currentImage = streamData["originalImage"] as td.Uint8List;
    }
  }

  // When image is taken
  Future<void> onMediaCaptureEvent(BuildContext context, MediaCapture event) async {
    if (CameraPageState.isShowingImage) {
      return;
    }

    CameraPageState.isShowingImage = true;

    YOLOResultPreProcessing.updateYOLOResultTraits();

    _showBestImage(context);

    Future.delayed(Duration(milliseconds: 500), () {
      CameraPageState.isShowingImage = false;
    });
  }

  Future<void> onImageFromGallery(BuildContext context) async {
    await _preprocessImageFromGallery(context);

    _showBestImage(context);
  }

  Future<bool> getImageFromGallery() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ALLOWED_FILE_EXTENSIONS,
    );

    if(result == null || result.files.isEmpty || result.files.first.path == null){
      return false;
    }

    File file = File(result.files.first.path!);

    imageBytes = await file.readAsBytes();

    return true;
  }

  Future<void> _preprocessImageFromGallery(BuildContext context) async {
    final results = await yoloAnalysis.yolo.predict(imageBytes!);

    if(results.containsKey("boxes")) {
      yoloAnalysis.currentResults = YOLOAnalysis.resultsToYOLOResults(results, isFromStream: false);
    }
    else {
      yoloAnalysis.currentResults = [];
    }

    yoloAnalysis.currentImage = results["annotatedImage"] as td.Uint8List; // bytes

    YOLOResultPreProcessing.updateYOLOResultTraits();
  }

  void _showBestImage(BuildContext context, {double angle = 0}) {
    YOLOResult? bestResult = yoloAnalysis.currentBestResult;

    img.Image croppedImage = img.decodeImage(yoloAnalysis.currentImage)!;

    // img.Image croppedImage = img.copyCrop(
    //     img.decodeImage(yoloAnalysis.currentImage)!,
    //     x: 0,
    //     y: 0,
    //     width: 640,
    //     height: 480
    // );

    // if(bestResult != null) {
    //   Rect rect = yoloAnalysis.currentBestResult!.boundingBox;
    //
    //   croppedImage = img.copyCrop(
    //       img.decodeImage(yoloAnalysis.currentImage)!,
    //       x: rect.center.dx.toInt() - 50,
    //       y: rect.center.dy.toInt() - 50,
    //       width: rect.center.dx.toInt() + 50,
    //       height: rect.center.dy.toInt() + 50,
    //   );
    // }

    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => PhotoPage(image: croppedImage, angle: angle),
      ),
    );
  }
}