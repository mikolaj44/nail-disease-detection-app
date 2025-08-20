import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../utils/dimension_utils.dart';
import '../../utils/style_methods.dart';
import '../page/camera/camera_page.dart';

class CameraTutorialPage extends StatelessWidget {
  const CameraTutorialPage({super.key});

  @override
  Widget build(BuildContext context){
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
                  width: getWidth(context) * 0.9,
                  height: getHeight(context) * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 0, 0, 0),
                        Color.fromARGB(255, 61, 61, 61)
                      ],
                      begin: Alignment.topCenter,
                    ),
                  ),

                  child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getWidth(context) * 0.05,
                        vertical: getHeight(context) * 0.05,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: getHeight(context) * 0.1,
                            child: Align(
                              alignment: Alignment.center,
                              child: AutoSizeText(
                                  context.tr("tutorial_title"),
                                  textAlign: TextAlign.center,
                                  wrapWords: false,
                                  minFontSize: 0,
                                  maxLines: 2,
                                  style: getTextStyle(context, Color.fromARGB(255, 255, 255, 255), fontSize: getMinDimension(context) * 60)
                              ),
                            ),
                          ),
                          Divider(thickness: 2),
                          SizedBox(
                            height: getHeight(context) * 0.3,
                            child: Align(
                              alignment: Alignment.center,
                              child: AutoSizeText(
                                  context.tr("tutorial_1"),
                                  textAlign: TextAlign.left,
                                  wrapWords: false,
                                  minFontSize: 0,
                                  style: getTextStyle(context, Color.fromARGB(255, 255, 255, 255), fontSize: getMinDimension(context) * 60)
                              ),
                            ),
                          ),
                          Divider(thickness: 2),
                          SizedBox(
                            height: getHeight(context) * 0.2,
                            child: Align(
                              alignment: Alignment.center,
                              child: AutoSizeText(
                                  context.tr("tutorial_2"),
                                  textAlign: TextAlign.left,
                                  wrapWords: false,
                                  minFontSize: 0,
                                  style: getTextStyle(context, Color.fromARGB(255, 255, 255, 255), fontSize: getMinDimension(context) * 60)
                              ),
                            ),
                          ),
                          Divider(thickness: 2),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.black, width: 2),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 6, 6, 6),
                                    Color.fromARGB(255, 61, 61, 61)
                                  ],
                                  begin: Alignment.bottomCenter,
                                ),
                              ),

                              width: getWidth(context) * 0.5,
                              height: getHeight(context) * 0.1,

                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) => const CameraPage(),
                                      //transitionsBuilder: getSlideTransition(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: BorderSide(
                                        color: Colors.white
                                    ),
                                  ),
                                  foregroundColor: Colors.transparent,
                                  side: BorderSide(
                                    color: Colors.white
                                  ),
                                ),

                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: getWidth(context) * 0.04,
                                    vertical: getHeight(context) * 0.03,
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: AutoSizeText(
                                        context.tr("go_to_camera_button"),
                                        textAlign: TextAlign.left,
                                        wrapWords: false,
                                        minFontSize: 0,
                                        style: getTextStyle(context, Color.fromARGB(255, 255, 255, 255), fontSize: 10000)
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                  )
              )
          )
        ),
      ),
    );
  }
}