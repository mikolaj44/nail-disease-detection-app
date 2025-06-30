import 'package:flutter_application_1/utils/other/dimension_utils.dart';
import 'package:flutter/material.dart';

import '../../controller/preanalysis/preanalysis_controller.dart';
import '../../model/preanalysis/yolo_result_preprocessing.dart';
import '../../utils/other/style/style_methods.dart';

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
        padding: EdgeInsets.only(bottom: getHeight(context) * 0.02),
        child: Container(
          width: getWidth(context) * 0.7,
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
      wasUpdated = true;
    }

    print("updating");

    List<YOLOResultTrait> traits = yoloAnalysis.currentBestTraits;

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
                    size: getWidth(context) / 9,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  DefaultTextStyle(
                      style: getTextStyle(context, Colors.white, fontSize: 0.016),
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