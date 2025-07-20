import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/preanalysis/preanalysis_controller.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/utils/other/dimension_utils.dart';
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
                        Expanded(
                            child:
                            AwesomeFlashButton(
                                state: state,
                                iconBuilder: ((flashMode) {
                                  final IconData icon;
                                  switch (flashMode) {
                                    case FlashMode.none:
                                      icon = Icons.flash_off;
                                      break;
                                    case FlashMode.on:
                                      icon = Icons.flashlight_on;
                                      break;
                                    case FlashMode.auto:
                                      icon = Icons.flash_off;
                                      break;
                                    case FlashMode.always:
                                      icon = Icons.flashlight_on;
                                      break;
                                  }
                                  return AwesomeCircleWidget.icon(
                                    icon: icon,
                                  );
                                }),
                                onFlashTap: (sensorConfig, flashMode) {
                                  final FlashMode newFlashMode;
                                  switch (flashMode) {
                                    case FlashMode.none:
                                      newFlashMode = FlashMode.always;
                                      break;
                                    case FlashMode.on:
                                      newFlashMode = FlashMode.none;
                                      break;
                                    case FlashMode.auto:
                                      newFlashMode = FlashMode.always;
                                      break;
                                    case FlashMode.always:
                                      newFlashMode = FlashMode.none;
                                      break;
                                  }
                                  sensorConfig.setFlashMode(newFlashMode);
                                }
                            )
                        ),
                      ],
                    );
                  },

                  middleContentBuilder: (state) {
                    return IgnorePointer(
                        ignoring: true,
                        child: YOLOPage()
                    );
                  },

                  bottomActionsBuilder: (state) {
                    if (analysis.viewHasLoaded) {
                      return AwesomeBottomActions(
                        state: state,
                        left: AwesomeCameraSwitchButton(
                          state: state,
                          scale: 0,
                          onSwitchTap: (state) {},
                        ),
                        right: SizedBox(),
                      );
                    }
                    else {
                      return Container(
                        width: getWidth(context),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8)
                        ),
                        child: SizedBox(
                          width: getWidth(context) * 0.5,
                          child: AutoSizeText(
                              context.tr("ai_loading"),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              wrapWords: false,
                              minFontSize: 0,
                              style: getTextStyle(
                                  context, Colors.white,
                                  fontSize: getMinDimension(context) * 500
                              )
                          ),
                        ),
                      );
                    }
                  },

                  onMediaCaptureEvent: (event) async {
                    preAnalysisController.onMediaCaptureEvent(context, event);
                  },
                ),
              ]
          );
        });
  }
}
