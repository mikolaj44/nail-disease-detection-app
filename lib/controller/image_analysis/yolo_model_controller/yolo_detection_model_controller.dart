part of "yolo_model_controller.dart";

class YOLODetectionModelController extends YOLOModelController<Uint8List> {
  final int _outputImageWidth;
  final int _outputImageHeight;

  const YOLODetectionModelController({required super.yoloModel, required int outputImageWidth, required int outputImageHeight}) : _outputImageWidth = outputImageWidth, _outputImageHeight = outputImageHeight;

  @override
  Future<Uint8List?> postProcessCurrentImageBytes() async {
    int x = (_yoloModel.currentResults.first.boundingBox.left).toInt();
    int y = (_yoloModel.currentResults.first.boundingBox.top).toInt();
    int rectWidth = (_yoloModel.currentResults.first.boundingBox.width).toInt();
    int rectHeight = (_yoloModel.currentResults.first.boundingBox.height).toInt();

    print(_yoloModel.currentResults.first);

    // TODO: get this 100% right
    img.Image croppedImage = img.copyCrop(
        img.decodeImage(_yoloModel.currentImage)!,
        x: x.toInt(), // - rectWidth / 2 - rectWidth / 2
        y: y.toInt(),
        width: rectWidth,
        height: rectHeight
    );

    return img.encodePng(croppedImage);
  }

  get outputImageWidth => _outputImageWidth;
  get outputImageHeight => _outputImageHeight;
}