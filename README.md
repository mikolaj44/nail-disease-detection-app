# NOTE: Work in progress, detecting diseases needs to be improved

# App designed for preliminary detection of nail diseases

Created as part of the "Practice" student research group

When it comes to detecting the nails, we are using a YOLOv12n model trained on this dataset by Molka: https://universe.roboflow.com/molka-dztlf/nail_detection-rmp3o, it consists of 9302 images, 70% were used for training, 15% for validation and 15% for testing. 50 epochs were run for now. The model was converted to tflite and we use the float32 version (around 10.4 MB in size).

We are using a float16 YOLOv11m-cls converted to tflite for disease classification, although we are testing other models too.

## What still needs to be done: (most to least important)

Prepare a better classification dataset

Some parameters to determine if a nail is healthy or not (like 70% certainty etc.)

Faster analysis of images from gallery - scale them down before analysing

Some visual changes like displaying the info popups in a more intuitive way and some others

## What has been done

Trained a YOLOv11m-cls model (and a YOLO11n-cls) on a custom nail disease detection dataset

Added a screen displaying the classification results

Image cropping and calculating the brightness for the cropped image

Refactoring

# Before this meeting

Blocking user from analysing the image if there are either none or more than one nails detected. Maybe later there could be a functionality that lets users select an area with the nail if it wasn't detected or pick one of multiple detected nails

Added popups that appear when there is an issue with the image (too dark, 0 detections, more than 1 detection)

# Before last meeting

Switched from the YOLOv8n model for preanalysis to a YOLOv12n model trained on a dataset 3 times the size, it stopped labeling objects like keyboard keys as nails and is much more certain (although a bit slower)

Settings menu (design and functionality)

A full English translation

Refactored the navigation bar, it now also shows which page is active. The slide animation still needs to be added

Proper main menu scaling

Simple camera tutorial page, tutorial/introduction pages now get shown only if the user hasn't seen them before

Fixed centering and the button graphical bug on introduction page

Adjusted the brightness value for which the image is considered too dark

Removed the camera switch button (for now)
