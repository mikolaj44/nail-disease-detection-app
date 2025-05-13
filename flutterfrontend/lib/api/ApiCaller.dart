import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../exceptions/invalidImageException.dart';

//import 'dart:convert';

// flutter run -d chrome --web-browser-flag "--disable-web-security"

class ApiCaller{
  
  static Future<String> getResult(Image image) async {
    try{
      final response = await http.get(Uri.parse('http://192.168.19.198:8080/api'));

      return response.body;
    }
    catch(e){
      return e.toString();
    }

  }

  static Future<Image> getImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if(result == null){
      throw InvalidimageException("Selected image does not exist");
    }

    File file = File(result.files.single.path!);

    if(await file.length() >= 5 * 1024 * 1024){
      throw InvalidimageException("Selected image is too large");
    }

    // TODO: check if the file is an image

    return Image.file(file);
  }

}

//TODO: put this in the IOS manifest file:

// <!-- Required to fetch data from the internet. -->
// <key>com.apple.security.network.client</key>
// <true/>