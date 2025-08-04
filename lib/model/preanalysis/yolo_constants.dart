// Located in android/app/assets/ (todo: move it so it can be used by both IOS and Android)
const String MODEL_NAME = "yolov12n 50e 640 float32";

// Depends on the model
const int IMAGE_WIDTH = 640;
// const int IMAGE_HEIGHT = 480;

// Nail detection parameters
const double MIN_BRIGHTNESS = 0.07;
const double CONFIDENCE_THRESHOLD = 0.7;

// Performance
const double IOU_THRESHOLD = CONFIDENCE_THRESHOLD;
const int NUM_ITEMS_THRESHOLD = 5;
const int INFERENCE_FREQUENCY = 20;
const int MAX_FPS = 20;
const String CAMERA_RESOLUTION = "1080p";