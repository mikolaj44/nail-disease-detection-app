import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_application_1/utils/other/list_copy.dart';
import 'package:flutter/material.dart';
import 'package:ultralytics_yolo/yolo.dart';

import '../../controller/preanalysis/preanalysis_controller.dart';
import '../../utils/interfaces/copyable.dart';
import '../../utils/other/image_methods.dart';
import '../../model/preanalysis/yolo_constants.dart';

final YOLOResultTrait IS_NAIL = YOLOResultTrait("detection_positive", "detection_negative", 10);
final YOLOResultTrait IS_LIT = YOLOResultTrait("brightness_positive", "brightness_negative", 1);

//final YOLOResultTrait IS_IN_BOUNDS = YOLOResultTrait("Paznokieć w centrum", "Paznokieć nie w centrum", 1);
//final YOLOResultTrait IS_CORRECT_SIZE = YOLOResultTrait("Odpowiedni rozmiar obszaru", "Zły rozmiar obszaru", 1);

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
    YOLOResultTrait trait = YOLOResultTrait(_positiveMessage, _negativeMessage, score);
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
  static void updateYOLOResultTraits(){
    if(yoloAnalysis.currentResults.isEmpty){
      YOLOResultTrait isNail = initialTraits[0].copy();
      isNail.isPositive = false;
      yoloAnalysis.currentBestTraits = [isNail];
      return;
    }

    List<YOLOResultTrait> bestTraits = listCopy(initialTraits);

    for(YOLOResultTrait trait in bestTraits){
      trait.isPositive = false;
    }

    int bestScore = -1;

    for(YOLOResult result in yoloAnalysis.currentResults) {
      List<YOLOResultTrait> currentTraits = listCopy(initialTraits);
      int currentScore = 0;

      for(YOLOResultTrait trait in currentTraits){
        trait.isPositive = true;
      }

      if (result.confidence >= MIN_NAIL_THRESHOLD) {
        currentScore += IS_NAIL.score;
      }
      else {
        currentTraits[0].setPositive(false);
      }

      if(getImageBrightness(yoloAnalysis.currentImage) > MIN_BRIGHTNESS) {
        currentScore += IS_LIT.score;
      }
      else {
        currentTraits[1].setPositive(false);
      }

      if(currentScore > bestScore) {
        bestTraits = currentTraits;
        bestScore = currentScore;
      }
    }

    yoloAnalysis.currentBestTraits = listCopy(bestTraits);
  }
}