import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/model/preanalysis/yolo_model.dart';
import 'package:flutter_application_1/model/preanalysis/yolo_result_verification.dart';
import 'package:flutter_application_1/view/page/camera/photo_page.dart';
import 'package:flutter_application_1/view/info_popup/info_popup.dart';

import 'dart:io';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';

import 'package:image/image.dart' as img;
import 'dart:typed_data' as td;

import 'package:ultralytics_yolo/ultralytics_yolo.dart';

class ImageAnalysisController with ChangeNotifier {
  late td.Uint8List _imageBytes;

  bool _isLoadingImage = false;
  bool _isShowingImage = false;

  final YOLOModel _detectionModel;
  final YOLOModel _classificationModel;

  final double scale = 1.2;

  ImageAnalysisController({required detectionModel, required classificationModel}) : _detectionModel = detectionModel, _classificationModel = classificationModel;

  Future<void> init() async {
    await _detectionModel.init();
    await _classificationModel.init();
  }

  Future<void> onMediaCaptureEvent(BuildContext context) async {
    if (isShowingImage) {
      return;
    }

    _isShowingImage = true;

    // print("before classification (stream)");

    // await _classificationModel.onImageFromGallery(_detectionModel.currentImage);

    await _showNextScreen(context, YOLOResultVerification.getDetectionIssue(results: _detectionModel.currentResults, detectionImage: _detectionModel.currentImage), true);

    Future.delayed(Duration(milliseconds: 500), () {
      _isShowingImage = false;
    });
  }

  Future<bool> onGalleryChosen(BuildContext context) async {
    _setLoadingImage(true);

    bool result = await _getImageFromGallery();

    if(!result){
      _setLoadingImage(false);
      return false;
    }

    // print("before classification (gallery)");

    // await _classificationModel.onImageFromGallery(_imageBytes);

    await _detectionModel.onImageFromGallery(imageBytes);

    _setLoadingImage(false);

    await _showNextScreen(context, YOLOResultVerification.getDetectionIssue(results: _detectionModel.currentResults, detectionImage: _imageBytes), false);

    return true;
  }

  td.Uint8List get imageBytes => _imageBytes;
  bool get isLoadingImage => _isLoadingImage;
  bool get isShowingImage => _isShowingImage;

  void _setLoadingImage(bool isLoading) {
    _isLoadingImage = isLoading;
    notifyListeners();
  }

  Future<bool> _getImageFromGallery() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: allowedFileExtensions,
    );

    if(result == null || result.files.isEmpty || result.files.first.path == null){
      return false;
    }

    File file = File(result.files.first.path!);

    _imageBytes = await file.readAsBytes();

    return true;
  }

  Future<void> _showImage(BuildContext context, {double angle = 0}) async {
    img.Image croppedImage = img.copyResize(
        img.decodeImage(_detectionModel.currentImage)!,
        width: 640,
        height: 640
    );

    print(_detectionModel.currentResults.first.boundingBox);
    print(_detectionModel.currentResults.first.normalizedBox);
    print("");

    int rectWidth = (_detectionModel.currentResults.first.normalizedBox.width * _detectionModel.yoloModelSetup.imageWidth).toInt();
    int rectHeight = (_detectionModel.currentResults.first.normalizedBox.height * _detectionModel.yoloModelSetup.imageHeight).toInt();
    int x = (_detectionModel.currentResults.first.normalizedBox.left * 640).toInt();
    int y = (_detectionModel.currentResults.first.normalizedBox.top * 640).toInt();

    croppedImage = img.copyCrop(
        croppedImage,
        x: (y - rectHeight * (scale / 2)).toInt(),
        y: (_detectionModel.yoloModelSetup.imageHeight - x - rectWidth - rectWidth * (scale / 2)).toInt(),
        width: (rectHeight * scale).toInt(),
        height: (rectWidth * scale).toInt()
    );

    print("left, top: ${_detectionModel.currentResults.first.normalizedBox.left * 640} ${_detectionModel.currentResults.first.normalizedBox.top * 640}");
    print("final x, y: $x $y");
    print("final width, height: $rectWidth $rectHeight");

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

  Future<void> _showNextScreen(BuildContext context, ImageDetectionIssue issue, bool isFromStream) async {
    if(issue == ImageDetectionIssue.noIssues) {
      await _showImage(context, angle: isFromStream ? pi / 2 : 0);
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