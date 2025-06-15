import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/MainPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:camerawesome/pigeon.dart';
import 'package:path_provider/path_provider.dart';

import '../api/ApiCaller.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
      CameraAwesomeBuilder.awesome(
        saveConfig: SaveConfig.photo(),

        topActionsBuilder: (state) =>
            AwesomeTopActions(
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
            ),

          // middleContentBuilder: (state) {
          //         return Expanded(
          //           child: AwesomeZoomSelector(
          //             state: state as PhotoCameraState,
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

        onMediaTap: (mediaCapture)

    {
      //OpenFile.open(mediaCapture.filePath);
    },),

        Center(
      child: ImageIcon(
      AssetImage("resources/nailoutline.png"),
      size: screenWidth / 2.5,
      )
      ),
    ]);
  }
}
