import 'dart:typed_data' as td;
import 'package:flutter/cupertino.dart';
import 'package:image/image.dart' as img;

import 'dart:ui';
import 'dart:ui';

import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter_application_1/view/camera/camera_page.dart';

import '../../model/preanalysis/yolo_analysis.dart';
import '../../model/preanalysis/yolo_result_preprocessing.dart';
import '../../model/preanalysis/yolo_result_preprocessing.dart';
import '../../utils/other/style/style_methods.dart';
import '../../view/camera/photo_page.dart';

final YOLOAnalysis yoloAnalysis = YOLOAnalysis();

class PreAnalysisController {
  void init(){
    yoloAnalysis.init();
  }

  void updateCurrentYOLOResult(){
    YOLOResultPreProcessing.updateYOLOResultTraits();
  }

  void onStreamData(Map<String, dynamic> streamData){
    yoloAnalysis.setViewHasLoaded(true);

    if (streamData.containsKey("detections") && streamData["detections"] != null) {
      yoloAnalysis.currentResults = YOLOAnalysis.streamingResultsToYOLOResults(streamData);
    }

    if (streamData.containsKey("originalImage") && streamData["originalImage"] != null) {
      yoloAnalysis.currentImage = streamData["originalImage"] as td.Uint8List;
    }
  }

  Future<void> onMediaCaptureEvent(BuildContext context, MediaCapture event) async {
    if (CameraPageState.isShowingImage) {
      return;
    }

    CameraPageState.isShowingImage = true;

    Rect rect = yoloAnalysis.currentBestResult.boundingBox;

    img.Image croppedImage = img.copyCrop(
        img.decodeImage(yoloAnalysis.currentImage)!,
        x: 0, //rect.left.toInt(),
        y: 0, //rect.top.toInt(),
        width: 640,
        height: 480
    );

    updateCurrentYOLOResult();

    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => PhotoPage(croppedImage),
        //transitionsBuilder: getSlideTransition(Offset(0, 1)),
      ),
    );

    Future.delayed(Duration(milliseconds: 500), () {
      CameraPageState.isShowingImage = false;
    });
  }
}