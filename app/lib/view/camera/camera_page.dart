import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/preanalysis/preanalysis_controller.dart';
import 'package:flutter_application_1/view/camera/yolo_page.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:provider/provider.dart';

import '../../model/preanalysis/yolo_analysis.dart';
import '../../utils/other/style/style_methods.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  CameraPageState createState() => CameraPageState();
}

class CameraPageState extends State<CameraPage> {
  CameraState? cameraState;

  static bool isShowingImage = false;

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
                              style: getTextStyle(context, Colors.white),
                              child: Text("Ładowanie widoku AI...")
                          ),
                        ),
                      );
                    }
                  },

                  onMediaCaptureEvent: (event) async {
                    PreAnalysisController.onMediaCaptureEvent(context, event);
                  },
                ),
              ]);
        });
  }
}
