import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/preanalysis/YOLOPage.dart';
import 'package:flutter_application_1/pages/MainPage.dart';
import 'package:camerawesome/camerawesome_plugin.dart';

import '../api/ApiCaller.dart';
import 'PhotoPage.dart';

class CameraPage extends StatelessWidget {
  CameraPage({super.key});

  static final Duration MAX_WAIT_TIME = const Duration(seconds: 5);

  bool _shouldProcessFrame = false;
  CameraState? cameraState;
  String imagePath = "";

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

        imageAnalysisConfig: AnalysisConfig(),

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
              child: YOLOPage()
          );
        },

        onMediaCaptureEvent: (event) async {
          if(!YOLOPageState.resultIsValid()){
            return;
          }

          String? path = event.captureRequest.path;

          print("path: $path");

          if(path == null){
            return;
          }

          final endTime = DateTime.now().add(MAX_WAIT_TIME);

          while(!await File(path).exists()){
            if (DateTime.now().isAfter(endTime)) {
              throw Exception("Took too long waiting for file to exist: $path");
            }
            await Future.delayed(const Duration(milliseconds: 100));
          }

          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => PhotoPage(path),
              transitionsBuilder: getSlideTransition(),
            ),
          );
        },
    ),

        Center(
      child: ImageIcon(
      AssetImage("resources/nailoutline.png"),
      size: screenWidth / 2.5,
      )
      ),
    ]);
  }
}
