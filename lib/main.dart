import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/page_switching/page_switching_controller.dart';
import 'package:flutter_application_1/controller/preanalysis/preanalysis_controller.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/controller/storage/storage_controller.dart';
import 'package:flutter_application_1/view/info/info_page.dart';
import 'package:flutter_application_1/view/main/main_page.dart';
import 'package:flutter_application_1/view/navigation_bar/custom_navigation_bar_button.dart';
import 'package:flutter_application_1/view/navigation_bar/custom_navigation_bar.dart';
import 'package:flutter_application_1/view/home/home_page.dart';
import 'package:flutter_application_1/view/introduction/introduction_page.dart';
import 'package:flutter_application_1/view/settings/settings_page.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

final String REPOSITORY_URL = "https://github.com/mikolaj44/nail-disease-detection-app";

final ALLOWED_FILE_EXTENSIONS = ['png', 'jpg', 'tiff', 'bmp'];

final LANGUAGES = ["Polski", "English"];
final LOCALES = [Locale('pl', 'PL'), Locale('en', 'UK')];

PreAnalysisController preAnalysisController = PreAnalysisController();
StorageController storageController = StorageController();

List<CustomNavigationBarButton> buttons = [CustomNavigationBarButton(switchWidget: SettingsPage(), iconData: Icons.accessibility_rounded, iconColor: Colors.white60), CustomNavigationBarButton(switchWidget: HomePage(), iconData: Icons.home_rounded, iconColor: Colors.white), CustomNavigationBarButton(switchWidget: InfoPage(), iconData: Icons.contact_support_rounded, iconColor: Colors.white60)];
CustomNavigationBar customNavigationBar = CustomNavigationBar(buttons: buttons);

PageSwitchingController pageSwitchingController = PageSwitchingController(customNavigationBar: customNavigationBar);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  await preAnalysisController.init();
  await storageController.init();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Normal Portrait
    DeviceOrientation.portraitDown, // Upside-Down Portrait
  ]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => yoloAnalysis),
        ChangeNotifierProvider(create: (context) => storageController),
        ChangeNotifierProvider(create: (context) => pageSwitchingController),
      ],
      child: EasyLocalization(
        supportedLocales: LOCALES,
        path: 'assets/translations',
        fallbackLocale: LOCALES[1],
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

    context.setLocale(LOCALES[LANGUAGES.indexOf(language)]);

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