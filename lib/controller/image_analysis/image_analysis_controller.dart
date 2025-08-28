import 'package:flutter_application_1/controller/image_analysis/yolo_model_controller/yolo_model_controller.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/model/preanalysis/yolo_utils.dart';
import 'package:flutter_application_1/view/page/final_result_page.dart';
import 'package:flutter_application_1/view/info_popup/info_popup.dart';

import 'dart:io';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';

import 'dart:typed_data' as td;

import 'package:ultralytics_yolo/ultralytics_yolo.dart';

class ImageAnalysisController with ChangeNotifier {
  bool isShowingImage = false;

  td.Uint8List? _imageBytes = td.Uint8List.fromList([]);

  bool _isLoadingImage = false;

  final YOLOModelController _detectionModelController;
  final YOLOModelController _classificationModelController;

  ImageAnalysisController({required YOLOModelController detectionModelController, required YOLOModelController classificationModelController}) : _detectionModelController = detectionModelController, _classificationModelController = classificationModelController;

  Future<void> init() async {
    await _detectionModelController.init();
    await _classificationModelController.init();
  }

  Future<bool> onMediaCaptureEvent(BuildContext context) async {
    ImageDetectionIssue issue = ImageDetectionIssue.noDetections;

    if(_detectionModelController.hasResults()) {
      _imageBytes = await _detectionModelController.processImageBytes(_detectionModelController.yoloModel.currentImage!);
      // _imageBytes = await _detectionModelController.postProcessCurrentImageBytes();

      issue = getDetectionIssue(
          results: _detectionModelController.yoloModel.currentResults,
          detectionImage: _imageBytes!
      );
    }

    if(issue != ImageDetectionIssue.noIssues) {
      if(!context.mounted) {
        return false;
      }

      await _showIssueScreen(context, issue, true);
      return false;
    }

    YOLOResult yoloResult = await _classificationModelController.processImageBytes(_imageBytes!);

    if(!context.mounted) {
      return false;
    }

    _showFinalResultPage(context, yoloResult, true);

    return true;
  }

  Future<bool> onGalleryChosen(BuildContext context) async {
    _setLoadingImage(true);

    bool result = await _getImageFromGallery();

    _setLoadingImage(false);

    if(!result) {
      return false;
    }

    ImageDetectionIssue issue = ImageDetectionIssue.noDetections;

    _imageBytes = await _detectionModelController.processImageBytes(_imageBytes!);

    if(_imageBytes != null) {
      issue = getDetectionIssue(
          results: _detectionModelController.yoloModel.currentResults,
          detectionImage: _imageBytes!
      );
    }

    if(issue != ImageDetectionIssue.noIssues) {
      if(!context.mounted) {
        return false;
      }

      await _showIssueScreen(context, issue, true);
      return false;
    }

    YOLOResult yoloResult = await _classificationModelController.processImageBytes(_imageBytes!);

    if(!context.mounted) {
      return false;
    }

    _showFinalResultPage(context, yoloResult, false);

    return true;
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

  void _showFinalResultPage(BuildContext context, YOLOResult result, bool isFromStream) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            FinalResultPage(
                imageBytes: _imageBytes!,
                diseaseName: result.className,
                confidence: result.confidence,
                angle: isFromStream ? pi / 2 : 0
            ),
      ),
    );
  }


  Future<void> _showIssueScreen(BuildContext context, ImageDetectionIssue issue, bool isFromStream) async {
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

  void _setLoadingImage(bool isLoading) {
    _isLoadingImage = isLoading;
    notifyListeners();
  }

  td.Uint8List get imageBytes => _imageBytes!;
  bool get isLoadingImage => _isLoadingImage;
}