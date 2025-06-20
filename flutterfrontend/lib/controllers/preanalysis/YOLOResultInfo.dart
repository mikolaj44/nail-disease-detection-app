import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/preanalysis/YOLOPage.dart';
import 'package:ultralytics_yolo/yolo.dart';
import 'package:provider/provider.dart';

import '../../pages/MainPage.dart';

final YOLOResultTrait IS_NAIL = YOLOResultTrait("Wykryto paznokieć", "Nie wykryto paznokcia", 10);
final YOLOResultTrait IS_IN_BOUNDS = YOLOResultTrait("Paznokieć w centrum", "Paznokieć nie w centrum", 1);
final YOLOResultTrait IS_CORRECT_SIZE = YOLOResultTrait("Odpowiedni rozmiar obszaru", "Zły rozmiar obszaru", 1);

class YOLOResultTrait {
  final String _positiveMessage;
  final String _negativeMessage;
  final int score;

  bool isPositive = true;

  YOLOResultTrait(this._positiveMessage, this._negativeMessage, this.score);

  YOLOResultTrait copy() => YOLOResultTrait(_positiveMessage, _negativeMessage, score);

  void setPositive(bool isPositive){
    this.isPositive = isPositive;
  }

  String getMessage(){
    return isPositive ? _positiveMessage : _negativeMessage;
  }
}

class YOLOResultInfo {

  static List<YOLOResultTrait> getBestYOLOResultTraits(List<YOLOResultTrait> initialTraits, List<YOLOResult> results, double minThreshold, Rect detectionRect){
    List<YOLOResultTrait> bestTraits = initialTraits;

    int bestScore = 0;

    for(YOLOResult result in results) {
      List<YOLOResultTrait> currentTraits = [IS_NAIL.copy(), IS_IN_BOUNDS.copy(), IS_CORRECT_SIZE.copy()];
      int currentScore = 0;

      if (result.confidence >= minThreshold) {
        currentScore += IS_NAIL.score;
      }
      else {
        currentTraits[0].setPositive(false);
      }

      if(detectionRect.contains(result.boundingBox.center)){
        currentScore += IS_IN_BOUNDS.score;
      }
      else {
        currentTraits[1].setPositive(false);
      }

      // TODO: check if the detection region isn't too small or too big
      currentTraits[2].setPositive(true);
      currentScore += IS_CORRECT_SIZE.score;

      if(currentScore > bestScore){
        bestTraits = currentTraits;
        bestScore = currentScore;
      }
    }

    return bestTraits;
  }
}

class YOLOResultWidget extends StatefulWidget {
  const YOLOResultWidget({super.key});

  @override
  YOLOResultWidgetState createState() => YOLOResultWidgetState();
}

class YOLOResultWidgetState extends State<YOLOResultWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<YOLOAnalysis>(
        builder: (context, analysis, child) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                child: Container(
                  width: screenWidth * 0.7,
                  decoration: BoxDecoration(color: Colors.white,
                      borderRadius: BorderRadius.circular(16)),
                  padding: EdgeInsets.all(6.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: getResultWidgetList(analysis.bestTraits),
                  ),
                ),
              ),
            );
        });
  }

  List<Widget> getResultWidgetList(List<YOLOResultTrait> traits){
    List<Widget> widgets = [];

    String text;
    Color color;
    IconData iconData;

    for(YOLOResultTrait trait in traits) {
      text = trait.getMessage();

      if(trait.isPositive) {
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