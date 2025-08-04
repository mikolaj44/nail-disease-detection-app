import 'dart:io';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/main.dart';
import 'package:camerawesome/camerawesome_plugin.dart';

import 'package:image/image.dart' as img;
import 'dart:typed_data' as td;

import '../../model/preanalysis/yolo_analysis.dart';
import '../../model/preanalysis/yolo_result_verification.dart';
import '../../view/camera/camera_page.dart';
import '../../view/camera/photo_page.dart';
import '../../view/info_popup/info_popup.dart';

final YOLOAnalysis yoloAnalysis = YOLOAnalysis();

class ImageAnalysisController {
  late td.Uint8List imageBytes;

  Future<void> init() async {
    yoloAnalysis.init();
  }

  Future<void> onMediaCaptureEvent(BuildContext context, MediaCapture event) async {
    if (CameraPageState.isShowingImage) {
      return;
    }

    CameraPageState.isShowingImage = true;

    _showNextScreen(context, YOLOResultVerification.getDetectionIssue(results: yoloAnalysis.currentResults, detectionImage: yoloAnalysis.currentImage), true);

    Future.delayed(Duration(milliseconds: 500), () {
      CameraPageState.isShowingImage = false;
    });
  }

  Future<bool> onGalleryChosen(BuildContext context) async {
    bool result = await _getImageFromGallery();

    if(!result){
      return false;
    }

    await yoloAnalysis.onImageFromGallery(imageBytes);

    _showNextScreen(context, YOLOResultVerification.getDetectionIssue(results: yoloAnalysis.currentResults, detectionImage: yoloAnalysis.currentImage), false);

    return true;
  }

  Future<bool> _getImageFromGallery() async {
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

  void _showImage(BuildContext context, {double angle = 0}) {
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

  void _showNextScreen(BuildContext context, ImageDetectionIssue issue, bool isFromStream) {
    print("results:");
    print(yoloAnalysis.currentResults);

    if(issue == ImageDetectionIssue.noIssues){
      _showImage(context, angle: isFromStream ? pi / 2 : 0);
      return;
    }
    
    late Widget nextScreen;

    switch(issue){
      case ImageDetectionIssue.multipleDetections:
        nextScreen = MultipleDetectionsPopup(transparentBackground: false, widthPercentage: 0.9, heightPercentage: 0.5);
      case ImageDetectionIssue.tooDark:
        nextScreen = TooDarkPopup(transparentBackground: false, widthPercentage: 0.9, heightPercentage: 0.5);
      case ImageDetectionIssue.noDetections:
        nextScreen = NoDetectionsPopup(transparentBackground: false, widthPercentage: 0.9, heightPercentage: 0.5);
      default:
        return;
    }

    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (context, animation, builder) =>
            Builder(builder: (context) {return nextScreen;})
      ),
    );
  }
}