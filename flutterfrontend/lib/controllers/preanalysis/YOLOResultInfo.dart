import 'dart:ui';
import 'dart:typed_data' as td;
import 'package:flutter_application_1/utils/list_copy.dart';
import 'package:image/image.dart' as img;

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/preanalysis/YOLOPage.dart';
import 'package:ultralytics_yolo/yolo.dart';
import 'package:provider/provider.dart';

import '../../interfaces/copyable.dart';
import '../../pages/MainPage.dart';

final YOLOResultTrait IS_NAIL = YOLOResultTrait("Wykryto paznokieć", "Nie wykryto paznokcia", 10);
final YOLOResultTrait IS_IN_BOUNDS = YOLOResultTrait("Paznokieć w centrum", "Paznokieć nie w centrum", 1);
final YOLOResultTrait IS_CORRECT_SIZE = YOLOResultTrait("Odpowiedni rozmiar obszaru", "Zły rozmiar obszaru", 1);
final YOLOResultTrait IS_LIT = YOLOResultTrait("Odpowiednie oświetlenie", "Zbyt ciemne zdjęcie", 1);

class YOLOResultTrait implements Copyable<YOLOResultTrait> {
  final String _positiveMessage;
  final String _negativeMessage;
  final int score;
  bool isPositive = true;

  YOLOResultTrait(this._positiveMessage, this._negativeMessage, this.score);

  @override
  YOLOResultTrait copy() {
    YOLOResultTrait trait = YOLOResultTrait(_positiveMessage, _negativeMessage, score);
    trait.setPositive(isPositive);
    return trait;
  }

    void setPositive(bool isPositive){
      this.isPositive = isPositive;
    }

    String getMessage(){
      return isPositive ? _positiveMessage : _negativeMessage;
    }
}

double getImageBrightness(td.Uint8List imageData, {int skip = 1}){
  img.Image? image = img.decodeImage(imageData);

  if(image == null || image.data == null){
    return 0;
  }

  td.Uint8List? pixels = image.data?.toUint8List();

  if(pixels == null){
    return 0;
  }

  double colorSum = 0;
  final increment = 3 * skip;

  for (int i = 0; i < pixels.length; i += increment) {
    int r = pixels[i];
    int g = pixels[i + 1];
    int b = pixels[i + 2];
    colorSum += (r + g + b) / 3.0;
    //colorSum += r * 0.2126 + g * 0.7152 + b * 0.0722;
  }

  return colorSum / pixels.length;
}

class YOLOResultInfo {
  static Rect convertBoundingBox(Rect boundingBox){
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

    yoloAnalysis.bestTraits = listCopy(bestTraits);

    print("curr positive: ${bestTraits[0].isPositive}");
    print("positive: ${yoloAnalysis.bestTraits[0].isPositive}");
    //yoloAnalysis.currentBestResult = bestResult;
  }
}

class YOLOResultWidget extends StatefulWidget {
  const YOLOResultWidget({super.key});

  @override
  YOLOResultWidgetState createState() => YOLOResultWidgetState();
}

class YOLOResultWidgetState extends State<YOLOResultWidget> {
  bool wasUpdated = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    wasUpdated = false;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(bottom: screenHeight * 0.02),
        child: Container(
          width: screenWidth * 0.7,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16)
          ),
          padding: EdgeInsets.all(6.0),
          //child: analysis.currentResults.isNotEmpty ? Text(analysis.currentResults.first.boundingBox.toString(), style: getTextStyle(Colors.black),) : SizedBox(),
          //child: Text("${getImageBrightness(yoloAnalysis.currentImage, skip: 15)}")
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: getResultWidgetList(),
          ),
        ),
      ),
    );
  }

  List<Widget> getResultWidgetList(){
    if(!wasUpdated) {
      YOLOResultInfo.updateYOLOResultTraits();
      wasUpdated = true;
    }

    List<YOLOResultTrait> traits = yoloAnalysis.bestTraits;

    List<Widget> widgets = [];

    String text;
    Color color;
    IconData iconData;

    for(YOLOResultTrait trait in traits) {
      text = trait.getMessage();

      if(trait.isPositive) {
        print("green");
        color = Colors.green;
        iconData = Icons.check_circle_rounded;
      }
      else {
        color = Colors.red;
        iconData = Icons.error_rounded;
      }

      widgets.add(
          Container(
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8)
              ),
              child: Row(
                  children: [
                    Icon(
                        iconData,
                        size: screenWidth / 9,
                        color: Colors.white,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    DefaultTextStyle(
                        style: getTextStyle(Colors.white, fontSize: 0.016),
                        child: Text(text)
                    )
                  ],
              )
          )
      );
    }

    return widgets;
  }
}