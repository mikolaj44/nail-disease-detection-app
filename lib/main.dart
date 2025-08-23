import 'package:flutter_application_1/controller/page_switching/page_switching_controller.dart';
import 'package:flutter_application_1/controller/image_analysis/image_analysis_controller.dart';
import 'package:flutter_application_1/controller/storage/storage_controller.dart';
import 'package:flutter_application_1/model/preanalysis/yolo_model.dart';
import 'package:flutter_application_1/model/preanalysis/yolo_model_setup.dart';
import 'package:flutter_application_1/view/page/main_page.dart';
import 'package:flutter_application_1/view/introduction/introduction_page.dart';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

// Nail detection parameters
final double minBrightness = 0.07;
final double confidenceThreshold = 0.7;

final String repositoryUrl = "https://github.com/mikolaj44/nail-disease-detection-app";

final String tempStorageFolderName = "nail_app_temp";
final String tempPhotoName = "temp.jpg";

final List<String> allowedFileExtensions = ['png', 'jpg', 'tiff', 'bmp'];

final List<String> languages = ["Polski", "English"];
final List<Locale> locales = [Locale('pl', 'PL'), Locale('en', 'UK')];

YOLOModel detectionModel = YOLODetectionModel(
    yoloModelSetup: YOLOModelSetup(
        modelPath: "yolov12n 50e 640 float32",
        imageWidth: 640,
        imageHeight: 640,
        confidenceThreshold: confidenceThreshold,
        iouThreshold: confidenceThreshold,
        numItemsThreshold: 5,
        inferenceFrequency: 20,
        maxFps: 20,
        cameraResolution: "1080p",
        includeOriginalImage: true,
        includeProcessingTimeMs: true
    )
);

YOLOModel classificationModel = YOLODetectionModel(
    yoloModelSetup: YOLOModelSetup(
        modelPath: "yolov12n 50e 640 float32",
        imageWidth: 640,
        imageHeight: 640,
        confidenceThreshold: confidenceThreshold,
        iouThreshold: confidenceThreshold,
        numItemsThreshold: 5,
        inferenceFrequency: 20,
        maxFps: 20,
        cameraResolution: "1080p",
        includeOriginalImage: true,
        includeProcessingTimeMs: true
    )
);

ImageAnalysisController imageAnalysisController = ImageAnalysisController(detectionModel: detectionModel, classificationModel: classificationModel);
StorageController storageController = StorageController();

PageSwitchingController pageSwitchingController = PageSwitchingController(activePageIndex: 1);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  await imageAnalysisController.init();
  await storageController.init();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Normal Portrait
    DeviceOrientation.portraitDown, // Upside-Down Portrait
  ]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => detectionModel),
        ChangeNotifierProvider(create: (context) => storageController),
        ChangeNotifierProvider(create: (context) => pageSwitchingController),
        ChangeNotifierProvider(create: (context) => imageAnalysisController)
      ],
      child: EasyLocalization(
        supportedLocales: locales,
        path: 'assets/translations',
        fallbackLocale: locales[1],
        child: MyApp(),
      )
    ),

  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    String language = storageController.getLanguage();

    context.setLocale(locales[languages.indexOf(language)]);

    return MaterialApp(
        title: 'Nail App',
        debugShowCheckedModeBanner: false,

        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,

        home: Builder(
            builder: (context) {
              if(storageController.shouldDisplayIntroduction()) {
                return IntroductionPage();
              }
              return MainPage();
            }
        )
    );
  }
}