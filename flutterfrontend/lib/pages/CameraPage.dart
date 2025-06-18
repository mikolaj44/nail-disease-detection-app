import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/preanalysis/PreAnalyser.dart';
import 'package:flutter_application_1/pages/MainPage.dart';
import 'package:flutter_application_1/pages/PhotoPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:camerawesome/pigeon.dart';
import 'package:path_provider/path_provider.dart';

import '../api/ApiCaller.dart';

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
              Expanded(
                child: AwesomeAspectRatioButton(
                  state: state as PhotoCameraState,
                ),
              ),
            ],
          );
        },

          // middleContentBuilder: (state) {
          //         return Expanded(
          //           child: AwesomeMediaPreview(
          //             mediaCapture: state.captureState,
          //             onMediaTap: ,
          //           )
          //         );
          // },

      bottomActionsBuilder: (state) => AwesomeBottomActions(
        state: state,
        left: AwesomeCameraSwitchButton(
          state: state,
        ),
        // right: AwesomeMediaPreview(
        //   state: state,
        // ),
      ),

        onMediaCaptureEvent: (event) async {
          String? path = event.captureRequest.path;

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

          PreAnalyser.getModifiedImage(path).then((result) {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder:
                    (context, animation, secondaryAnimation) => PhotoPage(result),
                transitionsBuilder: getSlideTransition(),
              ),
            );
          });
        },
      //OpenFile.open(mediaCapture.filePath);
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
