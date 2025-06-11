import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/MainPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';
import 'package:camera/camera.dart';

import '../api/ApiCaller.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  CameraPageState createState() => CameraPageState();
}

class CameraPageState extends State<CameraPage> with WidgetsBindingObserver {
  late CameraController cameraController;
  bool cameraIsInitialized = false;
  late List<CameraDescription> cameras;

  void takeAndSendPhoto() {
    print("photo test");
  }

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    try {
      cameras = await availableCameras();

      cameraController = CameraController(cameras[0], ResolutionPreset.high);

      await cameraController.initialize();
      if (!mounted) return;

      setState(() {
        cameraIsInitialized = true;
      });
    } catch (e) {
      print("camera initialization error");
    }
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    if (!cameraIsInitialized) {
      return SafeArea(child: Center(child: CircularProgressIndicator()));
    }
    return Container(
      color: Colors.blue,
        child: Scaffold(
          extendBody: true,
          body: Stack(
            children: [
              CameraPreview(cameraController),
              Center(
                child: Image.asset(
                  'resources/nailoutline.png',
                  width: screenWidth / 2,
                  height: screenWidth / 2,
                ),
              ),

              Center(
                child: IconButton(
                  onPressed: takeAndSendPhoto,

                  icon: Icon(Icons.camera, size: screenWidth / 5),
                ),
              ),
            ],
          ),
        ),
    );
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}
