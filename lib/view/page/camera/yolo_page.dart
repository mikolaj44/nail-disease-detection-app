import 'package:flutter_application_1/model/preanalysis/yolo_model.dart';

import 'package:flutter/material.dart';
import 'package:ultralytics_yolo/yolo_view.dart';

class YOLOPage extends StatefulWidget {
  final YOLOModel _yoloModel;

  const YOLOPage({super.key, required yoloModel}) : _yoloModel = yoloModel;

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
                modelPath: widget._yoloModel.yoloModelSetup.modelPath,
                task: widget._yoloModel.getYOLOTask(),
                controller: widget._yoloModel.yoloViewController,
                cameraResolution: widget._yoloModel.yoloModelSetup.cameraResolution,
                streamingConfig: widget._yoloModel.yoloStreamingConfig,

                onStreamingData: (streamData) {
                  setState(() {
                    widget._yoloModel.onStreamData(streamData);
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