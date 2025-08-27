part of "yolo_model_controller.dart";

class YOLODetectionModelController extends YOLOModelController<Uint8List> {
  final int _outputImageWidth;
  final int _outputImageHeight;
  final double _croppedRectScale;

  const YOLODetectionModelController({required super.yoloModel, required int outputImageWidth, required int outputImageHeight, required double croppedRectScale}) : _outputImageWidth = outputImageWidth, _outputImageHeight = outputImageHeight, _croppedRectScale = croppedRectScale;

  @override
  Future<Uint8List?> postProcessCurrentImageBytes() async {
    img.Image croppedImage = img.copyResize(
        img.decodeImage(_yoloModel.currentImage)!,
        width: _outputImageWidth,
        height: _outputImageHeight
    );

    int rectWidth = (_yoloModel.currentResults.first.normalizedBox.width * _yoloModel.yoloModelSetup.imageWidth).toInt();
    int rectHeight = (_yoloModel.currentResults.first.normalizedBox.height * _yoloModel.yoloModelSetup.imageHeight).toInt();
    int x = (_yoloModel.currentResults.first.normalizedBox.left * _outputImageWidth).toInt();
    int y = (_yoloModel.currentResults.first.normalizedBox.top * _outputImageHeight).toInt();

    croppedImage = img.copyCrop(
        croppedImage,
        x: (y - rectHeight * ((_croppedRectScale - 1.0) / 2.0)).toInt(),
        y: (outputImageWidth - x - rectWidth - rectWidth * ((_croppedRectScale - 1.0) / 2.0)).toInt(),
        width: (rectHeight * _croppedRectScale).toInt(),
        height: (rectWidth * _croppedRectScale).toInt()
    );

    return img.encodePng(croppedImage);
  }

  get outputImageWidth => _outputImageWidth;
  get outputImageHeight => _outputImageHeight;
  get croppedRectScale => _croppedRectScale;
}