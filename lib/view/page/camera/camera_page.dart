import 'dart:io';

import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/utils/dimension_utils.dart';
import 'package:flutter_application_1/view/page/camera/yolo_page.dart';
import 'package:flutter_application_1/model/preanalysis/yolo_model.dart';
import 'package:flutter_application_1/utils/style_methods.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  CameraPageState createState() => CameraPageState();
}

class CameraPageState extends State<CameraPage> {
  CameraState? cameraState;
  bool isTakingImage = false;
  bool yoloViewEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<YOLOModel>(
        builder: (context, controller, child) {
          return Stack(
              children: [
                CameraAwesomeBuilder.awesome(
                  saveConfig: SaveConfig.photo(
                    pathBuilder: (sensors) async {
                      final directory = await getTemporaryDirectory();
                      final tempDirectory = await Directory(
                          '${directory.path}/$tempStorageFolderName').create(
                          recursive: true);
                      return SingleCaptureRequest(
                          '${tempDirectory.path}/$tempPhotoName',
                          sensors.first);
                    },
                  ),
                  sensorConfig: SensorConfig.single(
                      sensor: Sensor.position(SensorPosition.back)
                  ),

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
                    if (isTakingImage || !yoloViewEnabled) {
                      return SizedBox();
                    }
                    return IgnorePointer(
                        ignoring: true,
                        child: YOLOPage(yoloModel: detectionModel)
                    );
                  },

                  bottomActionsBuilder: (state) {
                    if (detectionModel.viewHasLoaded) {
                      return AwesomeBottomActions(
                          state: state,
                          left: AwesomeCameraSwitchButton(
                            state: state,
                            scale: 0,
                            onSwitchTap: (state) {},
                          ),
                          captureButton: _CustomCameraButton(state: state, setYoloEnabled: setYoloEnabled),
                          right: SizedBox()
                      );
                    }
                    else {
                      return Container(
                        width: getWidth(context),
                        height: getHeight(context) * 0.1,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
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
                    print("status: ${event.status}");

                    if (event.status != MediaCaptureStatus.success) {
                      return;
                    }
                    //setState(() {
                    isTakingImage = false;
                    //});
                    await imageAnalysisController.onMediaCaptureEvent(context);
                  },
                ),
              ]
          );
        });
  }

  void setYoloEnabled(bool isEnabled) {
    print("setting yolo enabled to $isEnabled");
    yoloViewEnabled = isEnabled;
    setState(() {});
  }
}

class _CustomCameraButton extends StatefulWidget {
  final CameraState state;
  final Function(bool) setYoloEnabled;

  const _CustomCameraButton({super.key, required this.state, required this.setYoloEnabled});

  @override
  _CustomCameraButtonState createState() => _CustomCameraButtonState();
}

class _CustomCameraButtonState extends State<_CustomCameraButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late double _scale;
  final Duration _duration = const Duration(milliseconds: 100);

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: _duration,
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.state is AnalysisController) {
      return Container();
    }
    _scale = 1 - _animationController.value;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: SizedBox(
        key: const ValueKey('cameraButton'),
        height: 80,
        width: 80,
        child: Transform.scale(
          scale: _scale,
          child: CustomPaint(
            painter: widget.state.when(
              onPhotoMode: (_) => CameraButtonPainter(),
              onPreparingCamera: (_) => CameraButtonPainter(),
              onVideoMode: (_) => VideoButtonPainter(),
              onVideoRecordingMode: (_) =>
                  VideoButtonPainter(isRecording: true),
            ),
          ),
        ),
      ),
    );
  }

  _onTapDown(TapDownDetails details) {
    HapticFeedback.selectionClick();
    _animationController.forward();
  }

  Future<void> _onTapUp(TapUpDetails details) async {
    print("before taking a picture");

    widget.setYoloEnabled(false);

    await CamerawesomePlugin.stop();

    //YOLOView.

    await Future.delayed(_duration, () {
      _animationController.reverse();
    });
    
    await Future.delayed(Duration(seconds: 2));

    await CamerawesomePlugin.start();

    onTap.call();

    //widget.setYoloEnabled(true);
  }

  _onTapCancel() {
    _animationController.reverse();
  }

  get onTap => () {
     widget.state.when(
          onPhotoMode: (photoState) => photoState.takePhoto(),
          onVideoMode: (videoState) => videoState.startRecording(),
          onVideoRecordingMode: (videoState) => videoState.stopRecording(),
     );
  };
}

class CameraButtonPainter extends CustomPainter {
  CameraButtonPainter();

  @override
  void paint(Canvas canvas, Size size) {
    var bgPainter = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    var radius = size.width / 2;
    var center = Offset(size.width / 2, size.height / 2);
    bgPainter.color = Colors.white.withValues(alpha: .5);
    canvas.drawCircle(center, radius, bgPainter);

    bgPainter.color = Colors.white;
    canvas.drawCircle(center, radius - 8, bgPainter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class VideoButtonPainter extends CustomPainter {
  final bool isRecording;

  VideoButtonPainter({
    this.isRecording = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var bgPainter = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    var radius = size.width / 2;
    var center = Offset(size.width / 2, size.height / 2);
    bgPainter.color = Colors.white.withValues(alpha: .5);
    canvas.drawCircle(center, radius, bgPainter);

    if (isRecording) {
      bgPainter.color = Colors.red;
      canvas.drawRRect(
          RRect.fromRectAndRadius(
              Rect.fromLTWH(
                17,
                17,
                size.width - (17 * 2),
                size.height - (17 * 2),
              ),
              const Radius.circular(12.0)),
          bgPainter);
    } else {
      bgPainter.color = Colors.red;
      canvas.drawCircle(center, radius - 8, bgPainter);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}