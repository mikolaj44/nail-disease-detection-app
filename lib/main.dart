import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/preanalysis/preanalysis_controller.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/controller/storage/storage_controller.dart';
import 'package:flutter_application_1/view/home/main_page.dart';
import 'package:flutter_application_1/view/introduction/introduction_page.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  PreAnalysisController.init();
  StorageController.init();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Normal Portrait
    DeviceOrientation.portraitDown, // Upside-Down Portrait
  ]);

  runApp(
    ChangeNotifierProvider(
      create: (context) => yoloAnalysis,
      child: const MyApp(),
    ),
    // EasyLocalization(
    //   supportedLocales: [
    //     Locale('pl', 'PL'),
    //     Locale('en', 'US'),
    //   ],
    //   path: 'assets/translations',
    //   fallbackLocale: Locale('pl', 'PL'),
    //
    //   child: ChangeNotifierProvider(
    //     create: (context) => yoloAnalysis,
    //     child: const MyApp(),
    //   ),
    // )
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
        home: MainPage()
        // home: Builder(
        //   builder: (context) {
        //     if(!StorageController.getBool("introduction")) {
        //       StorageController.setBool("introduction", true);
        //       return IntroductionPage();
        //     }
        //     return MainPage();
        //   }
        // )
    );
  }
}