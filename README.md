# NOTE: Work in progress, detecting diseases is not yet implemented

# App designed for preliminary detection of nail diseases

Created as part of the "Practice" student research group

When it comes to detecting the nails, we use a YOLOv12n model trained on this dataset by Molka: https://universe.roboflow.com/molka-dztlf/nail_detection-rmp3o, it consists of 9302 images, 70% were used for training, 15% for validation and 15% for testing. 50 epochs were run for now. The model was converted to tflite and we use the float32 version (around 10.4 MB in size).

## What still needs to be done:

Image cropping and calculating the brightness for the cropped image, not the full one as it is right now

Faster analysis of images from gallery - scale them down before analysing

Experimentation with some performance tweaks to the preanalysis model

## What has been done (since our last meeting)

Settings menu (design and functionality)

Full English translation

Refactored the navigation bar, it now also shows which page is active. The slide animation still needs to be added

Added proper main menu scaling

Fixed centering and the button graphical bug on introduction page

Adjusted the brightness value

Removed the camera switch button (for now)

Simple camera tutorial page, tutorial/introduction pages now get shown only if the user hasn't seen them before

Switched from the YOLOv8n model for preanalysis to a YOLOv12n model trained on a dataset 3 times the size, it stopped labeling objects like keyboard keys as nails and is much more certain (although a bit slower)