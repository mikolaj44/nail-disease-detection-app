import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/preanalysis/preanalysis_controller.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/controller/storage/storage_controller.dart';
import 'package:flutter_application_1/view/home/main_page.dart';
import 'package:flutter_application_1/view/introduction/introduction_page.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

final languages = ["Polski", "English"];
//final locales = [Locale('pl', 'PL'), Locale('en', 'UK')];

PreAnalysisController preAnalysisController = PreAnalysisController();
StorageController storageController = StorageController();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //await EasyLocalization.ensureInitialized();

  preAnalysisController.init();
  storageController.init();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Normal Portrait
    DeviceOrientation.portraitDown, // Upside-Down Portrait
  ]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => yoloAnalysis),
        ChangeNotifierProvider(create: (context) => storageController),
      ],
      child: const MyApp()
      // child: EasyLocalization(
      //   supportedLocales: locales,
      //   path: 'assets/translations',
      //   fallbackLocale:  locales.first,
      //   child: const MyApp(),
      // )
    ),

  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Nail App',
        debugShowCheckedModeBanner: false,
        // localizationsDelegates: context.localizationDelegates,
        // supportedLocales: context.supportedLocales,
        // locale: context.locale,
        home: Builder(
          builder: (context) {
            if(!storageController.getBool("introduction")) {
              storageController.setBool("introduction", true);
              return IntroductionPage();
            }
            return MainPage();
          }
        )
    );
  }
}