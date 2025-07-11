import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
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
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16)
          ),
          padding: EdgeInsets.all(6.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: getResultWidgetList(context),
          ),
        ),
      ),
    );
  }

  List<Widget> getResultWidgetList(BuildContext context){
    if(!wasUpdated) {
      wasUpdated = true;
    }

    List<YOLOResultTrait> traits = yoloAnalysis.currentBestTraits;

    List<Widget> widgets = [];

    String text;
    Color color;
    IconData iconData;

    for(YOLOResultTrait trait in traits) {
      text = context.tr(trait.getMessage());

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
              child: SizedBox(
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
                      SizedBox(
                          width: getWidth(context) * 0.5,
                          child:
                          AutoSizeText(
                              text,
                              maxLines: 1,
                              wrapWords: false,
                              minFontSize: 0,
                              style: getTextStyle(
                                  context, Colors.white,
                                  fontSize: 50
                              )
                          ),
                      )
                    ],
                  )
              ),
          )
      );
    }

    return widgets;
  }
}