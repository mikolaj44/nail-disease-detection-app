import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter_application_1/main.dart';

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

  Future<void> setString(String key, String value) async {
    await prefs.setString(key, value);
    notifyListeners();
  }

  String getString(String key){
    String? result = prefs.getString(key);

    return result ?? "null";
  }

  String getLanguage() {
    if(!storageController.getBool("language_set")){
      storageController.setBool("language_set", true);
      storageController.setString("language", LANGUAGES.first);
      return LANGUAGES.first;
    }

    return storageController.getString("language");
  }

  // If tutorial_set is not true then we haven't seen the tutorial yet - show the tutorial but keep it disabled
  bool shouldDisplayTutorial() {
    if(!storageController.getBool("tutorial_set")){
      storageController.setBool("tutorial_set", true);
      return true;
    }

    return storageController.getBool("tutorial");
  }

  // Same thing here
  bool shouldDisplayIntroduction() {
    if(!storageController.getBool("introduction_set")){
      storageController.setBool("introduction_set", true);
      return true;
    }

    return storageController.getBool("introduction");
  }
}