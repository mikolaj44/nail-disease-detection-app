import 'dart:ui';

import 'package:flutter_application_1/utils/other/list_copy.dart';
import 'package:flutter/material.dart';
import 'package:ultralytics_yolo/yolo.dart';

import '../../controller/preanalysis/preanalysis_controller.dart';
import '../../utils/interfaces/copyable.dart';
import '../../utils/other/image_methods.dart';
import '../../model/preanalysis/yolo_constants.dart';

final YOLOResultTrait IS_NAIL = YOLOResultTrait("Wykryto paznokieć", "Nie wykryto paznokcia", 10);
final YOLOResultTrait IS_IN_BOUNDS = YOLOResultTrait("Paznokieć w centrum", "Paznokieć nie w centrum", 1);
final YOLOResultTrait IS_CORRECT_SIZE = YOLOResultTrait("Odpowiedni rozmiar obszaru", "Zły rozmiar obszaru", 1);
final YOLOResultTrait IS_LIT = YOLOResultTrait("Odpowiednie oświetlenie", "Zbyt ciemne zdjęcie", 1);

class YOLOResultTrait implements Copyable<YOLOResultTrait> {
  final String _positiveMessage;
  final String _negativeMessage;
  final int _score;
  bool _isPositive = true;

  YOLOResultTrait(this._positiveMessage, this._negativeMessage, this._score);

  int get score {
    return _score;
  }

  set isPositive(bool value) {
    _isPositive = value;
  }

  bool get isPositive {
    return _isPositive;
  }

  @override
  YOLOResultTrait copy() {
    YOLOResultTrait trait = YOLOResultTrait(
        _positiveMessage, _negativeMessage, score);
    trait.setPositive(isPositive);
    return trait;
  }

  void setPositive(bool isPositive) {
    _isPositive = isPositive;
  }

  String getMessage() {
    return isPositive ? _positiveMessage : _negativeMessage;
  }
}

class YOLOResultPreProcessing {
  static Rect _convertBoundingBox(Rect boundingBox) {
    return Rect.fromLTRB(boundingBox.left, boundingBox.top, IMAGE_WIDTH - boundingBox.right, IMAGE_HEIGHT - boundingBox.bottom);
  }

  static void updateYOLOResultTraits(){
    List<YOLOResultTrait> bestTraits = listCopy(initialTraits);
    //YOLOResult bestResult = yoloAnalysis.currentBestResult;

    for(YOLOResultTrait trait in bestTraits){
      trait.isPositive = false;
    }

    int bestScore = 0;

    for(YOLOResult result in yoloAnalysis.currentResults) {
      List<YOLOResultTrait> currentTraits = listCopy(initialTraits);
      int currentScore = 0;

      if (result.confidence >= MIN_NAIL_THRESHOLD) {
        // print("curr: ${currentTraits[0].isPositive}");
        print("initial: ${initialTraits[0].isPositive}");
        currentScore += IS_NAIL.score;
      }
      else {
        currentTraits[0].setPositive(false);
      }

      //print("image: ${yoloAnalysis.currentImage}");
      //print("brightness: ${getImageBrightness(yoloAnalysis.currentImage)}");

      // if(yoloAnalysis.detectionRect.contains(convertBoundingBox(result.boundingBox).center)){
      //   currentScore += IS_IN_BOUNDS.score;
      // }
      // else {
      //   currentTraits[1].setPositive(false);
      // }

      if(getImageBrightness(yoloAnalysis.currentImage) > MIN_BRIGHTNESS) {
        currentScore += IS_LIT.score;
      }
      else {
        currentTraits[1].setPositive(false);
      }

      // TODO: check if the detection region isn't too small or too big
      // currentTraits[2].setPositive(true);
      // currentScore += IS_CORRECT_SIZE.score;

      if(currentScore > bestScore) {
        bestTraits = currentTraits;
        bestScore = currentScore;
        //bestResult = result;
      }
    }

    yoloAnalysis.currentBestTraits = listCopy(bestTraits);

    // print("curr positive: ${bestTraits[0].isPositive}");
    // print("positive: ${yoloAnalysis.currentBestTraits[0].isPositive}");
    //yoloAnalysis.currentBestResult = bestResult;
  }
}