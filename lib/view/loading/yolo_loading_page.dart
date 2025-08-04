import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../utils/dimension_utils.dart';
import '../../utils/style_methods.dart';

class YOLOLoadingPage extends StatelessWidget {
  const YOLOLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/waves.png"),
            fit: BoxFit.cover,
          ),
        ),
        child:
        Align(
            alignment: Alignment.center,
            child: Card(
                elevation: 20,
                child:
                Container(
                  height: getHeight(context) * 0.4,
                  width: getWidth(context) * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 0, 0, 0),
                        Color.fromARGB(255, 61, 61, 61)
                      ],
                      begin: Alignment.topCenter,
                    ),
                  ),

                  child: Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: getWidth(context) * 0.05,
                            vertical: getHeight(context) * 0.05,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: getHeight(context) * 0.1,
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: AutoSizeText(
                                      context.tr("yolo_loading"),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      wrapWords: false,
                                      minFontSize: 0,
                                      style: getTextStyle(context, Color.fromARGB(255, 255, 255, 255), fontSize: getMinDimension(context) * 500)
                                  ),
                                ),
                              ),

                              // CircularProgressIndicator(
                              //   color: Colors.white
                              // )
                            ],
                          )
                      )
                  ),
                )
            ),
        ),
      ),
    );
  }
}