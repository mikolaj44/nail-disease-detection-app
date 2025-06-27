import 'dart:typed_data' as td;
import 'package:image/image.dart' as img;

double getImageBrightness(td.Uint8List imageData, {int skip = 1}){
  img.Image? image = img.decodeImage(imageData);

  if(image == null || image.data == null){
    return 0;
  }

  td.Uint8List? pixels = image.data?.toUint8List();

  if(pixels == null){
    return 0;
  }

  double colorSum = 0;
  final increment = 3 * skip;

  for (int i = 0; i < pixels.length; i += increment) {
    int r = pixels[i];
    int g = pixels[i + 1];
    int b = pixels[i + 2];
    colorSum += (r + g + b) / 3.0;
    //colorSum += r * 0.2126 + g * 0.7152 + b * 0.0722;
  }

  return colorSum / pixels.length;
}