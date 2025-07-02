import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';

class StorageController {
  static late SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setBool(String key, bool value) async {
    await prefs.setBool(key, value);
  }

  static bool getBool(String key){
    bool? result = prefs.getBool(key);

    return result ?? false;
  }
  
  static Future<PlatformFile> getLocalFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'tiff', 'bmp'], // call api here
    );

    if (result != null) {
      return Future.value(result.files.first);
    } else {
      return Future.value(null); // probably throw an exception
    }
  }
}