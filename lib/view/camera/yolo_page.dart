import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:ultralytics_yolo/yolo.dart';
import 'package:ultralytics_yolo/yolo_streaming_config.dart';
import 'package:ultralytics_yolo/yolo_view.dart';

import '../../controller/preanalysis/preanalysis_controller.dart';
import '../../model/preanalysis/yolo_constants.dart';

class YOLOPage extends StatefulWidget {
  @override
  YOLOPageState createState() => YOLOPageState();
}

class YOLOPageState extends State<YOLOPage> {
  @override
  void initState() {
    super.initState();
  }

  // https://github.com/ultralytics/yolo-flutter-app/blob/main/doc/usage.md#real-time-camera-processing
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: [
            YOLOView(
                modelPath: MODEL_NAME,
                task: YOLOTask.detect,
                controller: yoloAnalysis.yoloViewController,
                cameraResolution: CAMERA_RESOLUTION,
                streamingConfig: yoloAnalysis.yoloStreamingConfig,

                onStreamingData: (streamData) {
                  setState(() {
                    preAnalysisController.onStreamData(streamData);
                  });
                },

              // This doesn't actually run if onStreamingData is provided, but removing onResult breaks the output
              onResult: (results) {
                setState(() {});
              }
          ),
        ]
      ),
    );
  }
}