import 'package:flutter_application_1/model/preanalysis/yolo_result_preprocessing.dart';

// Located in android/app/assets/ (todo: move it so it can be used by both IOS and Android)
const String MODEL_NAME = "yolov8n 40e 640 float16";

// Depends on the model
const int IMAGE_WIDTH = 640;
const int IMAGE_HEIGHT = 480;

// Nail detection info
const double MIN_NAIL_THRESHOLD = 0.6;
const int MIN_BRIGHTNESS = 80; // todo: test which value is okay

// Performance
const double CONFIDENCE_THRESHOLD = 0.5;
const double IOU_THRESHOLD = 0.4;
const int NUM_ITEMS_THRESHOLD = 5;
const int INFERENCE_FREQUENCY = 10;
const int MAX_FPS = 15;
const String CAMERA_RESOLUTION = "1080p";

// Ex. start from 30% of image length from all borders
const double CENTER_PERCENTAGE = 0.3;

// Minimum score for an image to be considered valid for further analysis
final int MIN_VALID_SCORE = IS_NAIL.score + IS_LIT.score;

// Initial, base traits
final List<YOLOResultTrait> initialTraits = [IS_NAIL, IS_LIT];