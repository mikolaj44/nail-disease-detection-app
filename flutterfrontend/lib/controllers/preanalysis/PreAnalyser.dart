import 'dart:io';

import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/preanalysis/MLKitUtils.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
import 'package:flutter_application_1/structures/triple.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

import '../../pages/PhotoPage.dart';

// https://pub.dev/documentation/google_mlkit_object_detection/latest/
class PreAnalyser {
  static final int IMAGE_WIDTH = 300;
  static final int IMAGE_HEIGHT = 300;
  static final double MIN_THRESHOLD = 0.4;

  static final bool SINGLE_DETECT = true;

  static final String MODEL_PATH = "assets/models/ssd_mobilenet_v1.tflite";
  static final String LABEL_PATH = "assets/other/coco_labelmap.txt";

  static Interpreter? objectDetector;

  static List<String>? labels;

  static Future<void> initModel() async {
    final interpreterOptions = InterpreterOptions();

    // Use XNNPACK Delegate
    if (Platform.isAndroid) {
      interpreterOptions.addDelegate(XNNPackDelegate());
    }

    // Use Metal Delegate
    if (Platform.isIOS) {
      interpreterOptions.addDelegate(GpuDelegate());
    }

    final data = await rootBundle.load(MODEL_PATH);

    final dir = await getTemporaryDirectory();

    final file = File('${dir.path}/ssd_mobilenet_v1.tflite');

    await file.writeAsBytes(data.buffer.asUint8List());

    objectDetector = Interpreter.fromFile(File(file.path), options: interpreterOptions);

    final labelsRaw = await rootBundle.loadString(LABEL_PATH);

    labels = labelsRaw.split('\n');
  }

  // https://github.com/tensorflow/flutter-tflite/blob/main/example/object_detection_ssd_mobilenet/lib/object_detection.dart
  static Future<img.Image> getModifiedImage(String imagePath) async {

    final imageData = File(imagePath).readAsBytesSync();

    final image = img.decodeImage(imageData);

    final imageInput = img.copyResize(
      image!,
      width: IMAGE_WIDTH,
      height: IMAGE_HEIGHT,
    );

    final imageMatrix = List.generate(
      imageInput.height,
          (y) => List.generate(
        imageInput.width,
            (x) {
          final pixel = imageInput.getPixel(x, y);
          return [pixel.r, pixel.g, pixel.b];
        },
      ),
    );

    final output = _runInference(imageMatrix);

    // Location
    final locationsRaw = output.first.first as List<List<double>>;

    final locations = locationsRaw.map((list) {
      return list.map((value) => (value * IMAGE_WIDTH).toInt()).toList();
    }).toList();

    // Classes
    final classesRaw = output.elementAt(1).first as List<double>;
    final classes = classesRaw.map((value) => value.toInt()).toList();

    // Scores
    final scores = output.elementAt(2).first as List<double>;

    // Number of detections
    final numberOfDetectionsRaw = output.last.first as double;
    var numberOfDetections = numberOfDetectionsRaw.toInt();

    if(SINGLE_DETECT){
      numberOfDetections = 1;
    }

    final List<String> classification = [];

    for (var i = 0; i < numberOfDetections; i++) {
      if(labels != null && classes[i] < labels!.length) {
        classification.add(labels![classes[i]]);
        print("added label ${labels![classes[i]]}, score: ${scores[i]}");
      }
    }

    for (var i = 0; i < numberOfDetections; i++) {
      if (scores[i] > MIN_THRESHOLD) {
        // Rectangle drawing
        print("drawn rect");
        img.drawRect(
          imageInput,
          x1: locations[i][1],
          y1: locations[i][0],
          x2: locations[i][3],
          y2: locations[i][2],
          color: img.ColorRgb8(255, 0, 0),
          thickness: 3,
        );

        // Label drawing
        img.drawString(
          imageInput,
          '${classification[i]} ${scores[i]}',
          font: img.arial14,
          x: locations[i][1] + 1,
          y: locations[i][0] + 1,
          color: img.ColorRgb8(255, 0, 0),
        );
      }
    }

    return imageInput;
  }

  static List<List<Object>> _runInference(List<List<List<num>>> imageMatrix) {
    // Set input tensor [1, 300, 300, 3]
    final input = [imageMatrix];

    // Set output tensor
    // Locations: [1, 10, 4]
    // Classes: [1, 10],
    // Scores: [1, 10],
    // Number of detections: [1]
    final output = {
      0: [List<List<num>>.filled(10, List<num>.filled(4, 0))],
      1: [List<num>.filled(10, 0)],
      2: [List<num>.filled(10, 0)],
      3: [0.0],
    };

    objectDetector!.runForMultipleInputs([input], output);
    return output.values.toList();
  }
}