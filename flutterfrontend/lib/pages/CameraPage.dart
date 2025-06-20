import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/preanalysis/YOLOPage.dart';
import 'package:flutter_application_1/controllers/preanalysis/YOLOResultInfo.dart';
import 'package:flutter_application_1/pages/MainPage.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:screenshot/screenshot.dart';

import 'PhotoPage.dart';

class CameraPage extends StatelessWidget {
  CameraPage({super.key});

  static final Duration MAX_WAIT_TIME = const Duration(seconds: 5);

  CameraState? cameraState;
  ScreenshotController screenshotController = ScreenshotController();

  bool captureWasHandled = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
      CameraAwesomeBuilder.awesome(
        saveConfig: SaveConfig.photo(),

        // onImageForAnalysis: (AnalysisImage image) async {
        //   if(!_shouldProcessFrame){
        //     return;
        //   }
        //
        //   _shouldProcessFrame = false;
        //
        //   PreAnalyser.getLabel(image).then((result) {
        //     Navigator.of(context).push(
        //       PageRouteBuilder(
        //         pageBuilder:
        //             (context, animation, secondaryAnimation) => PhotoPage(imagePath, "Result: ${result.a}", result.b, result.c),
        //         transitionsBuilder: getSlideTransition(),
        //       ),
        //     );
        //   });
        //
        //   cameraState?.analysisController?.stop();
        // },

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

        bottomActionsBuilder: (state) =>
            AwesomeBottomActions(
              state: state,
              left: AwesomeCameraSwitchButton(
                state: state,
              ),
              // right: AwesomeMediaPreview(
              //   state: state,
              // ),
            ),

        middleContentBuilder: (state){
          return IgnorePointer(
              ignoring: true,
              child: Stack(
                children: [
                  Screenshot(controller: screenshotController, child: YOLOPage()),
                  NailOutlineWidget(),
                  YOLOResultWidget()
                ]
              )
          );
        },

        onMediaCaptureEvent: (event) async {
          if(captureWasHandled || !yoloAnalysis.resultIsValid()){
            return;
          }

          captureWasHandled = true;

          Uint8List capturedImage = Uint8List(0);

          await screenshotController.capture().then((Uint8List? image) {
            if(image == null){
              return;
            }
            capturedImage = image;
          }).catchError((onError) {
            print(onError);
          });

          if(capturedImage.isEmpty){
            return;
          }

          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => PhotoPage(capturedImage),
              transitionsBuilder: getSlideTransition(),
            ),
          );

          captureWasHandled = false;
        },
      ),
    ]);
  }
}
