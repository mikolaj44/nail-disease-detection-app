import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';

class StorageController with ChangeNotifier {
  late SharedPreferences prefs;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> setBool(String key, bool value) async {
    await prefs.setBool(key, value);
    notifyListeners();
  }

  bool getBool(String key){
    bool? result = prefs.getBool(key);

    return result ?? false;
  }
  
  Future<PlatformFile> getLocalFile() async {
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