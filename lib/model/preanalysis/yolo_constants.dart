import 'package:flutter_application_1/model/preanalysis/yolo_result_preprocessing.dart';

// Located in android/app/assets/ (todo: move it so it can be used by both IOS and Android)
const String MODEL_NAME = "yolov12n 50e 640 float32";

// Depends on the model
const int IMAGE_WIDTH = 640;
// const int IMAGE_HEIGHT = 480;

// Nail detection info
const double MIN_NAIL_THRESHOLD = 0.7;
const double MIN_BRIGHTNESS = 0.1;

// Performance
const double CONFIDENCE_THRESHOLD = 0.5;
const double IOU_THRESHOLD = 0.4;
const int NUM_ITEMS_THRESHOLD = 5;
const int INFERENCE_FREQUENCY = 20;
const int MAX_FPS = 20;
const String CAMERA_RESOLUTION = "1080p";

// Ex. start from 30% of image length from all borders
const double CENTER_PERCENTAGE = 0.3;

// Minimum score for an image to be considered valid for further analysis
final int MIN_VALID_SCORE = IS_NAIL.score + IS_LIT.score;

// Initial, base traits
final List<YOLOResultTrait> initialTraits = [IS_NAIL, IS_LIT];