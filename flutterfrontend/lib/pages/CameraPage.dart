import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/preanalysis/YOLOPage.dart';
import 'package:flutter_application_1/controllers/preanalysis/YOLOResultInfo.dart';
import 'package:flutter_application_1/pages/MainPage.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:provider/provider.dart';
import 'package:image/image.dart' as img;

import 'PhotoPage.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  CameraPageState createState() => CameraPageState();
}

class CameraPageState extends State<CameraPage> {
  CameraState? cameraState;

  bool isShowingImage = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<YOLOAnalysis>(
        builder: (context, analysis, child) {
          return Stack(
              children: [
                CameraAwesomeBuilder.awesome(
                  saveConfig: SaveConfig.photo(),

                  topActionsBuilder: (state) {
                    cameraState = state;

                    return AwesomeTopActions(
                      padding: EdgeInsets.zero,
                      state: state,
                      children: [
                        Expanded(child: AwesomeFlashButton(state: state)),
                        // Expanded(
                        //   child: AwesomeAspectRatioButton(
                        //     state: state as PhotoCameraState,
                        //   ),
                        // ),
                        //
                      ],
                    );
                  },

                  middleContentBuilder: (state) {
                    return IgnorePointer(
                        ignoring: true,
                        child: Stack(
                            children: [
                              YOLOPage(),
                              //NailOutlineWidget(),
                              //YOLOResultWidget()
                            ]
                        )
                    );
                  },

                  bottomActionsBuilder: (state) {
                    if (analysis.viewHasLoaded) {
                      return AwesomeBottomActions(
                        state: state,
                        left: AwesomeCameraSwitchButton(
                          state: state,
                        ),
                        // right: AwesomeMediaPreview(
                        //   state: state,
                        // ),
                      );
                    }
                    else {
                      return Padding(
                        padding: EdgeInsets.all(20),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: DefaultTextStyle(
                              style: getTextStyle(Colors.white),
                              child: Text("Ładowanie widoku AI...")
                          ),
                        ),
                      );
                    }
                  },

                  onMediaCaptureEvent: (event) async {
                    if (isShowingImage) { //|| !yoloAnalysis.resultIsValid()
                      return;
                    }

                    isShowingImage = true;

                    Rect rect = yoloAnalysis.currentBestResult.boundingBox;

                    img.Image croppedImage = img.copyCrop(
                        img.decodeImage(yoloAnalysis.currentImage)!,
                        x: 0, //rect.left.toInt(),
                        y: 0, //rect.top.toInt(),
                        width: 640,
                        height: 480);

                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => PhotoPage(croppedImage),
                        transitionsBuilder: getSlideTransition(),
                      ),
                    );

                    Future.delayed(Duration(milliseconds: 200), () {
                      isShowingImage = false;
                    });
                  },
                ),
              ]);
        });
  }
}
