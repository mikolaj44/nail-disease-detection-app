import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/preanalysis/preanalysis_controller.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/view/camera/camera_page.dart';
import 'package:flutter_application_1/utils/other/dimension_utils.dart';
import 'package:flutter_application_1/view/introduction/camera_tutorial_page.dart';
import 'package:flutter_application_1/view/navigation_bar/custom_navigation_bar.dart';
import 'package:flutter_application_1/view/loading/yolo_loading_page.dart';
import 'package:provider/provider.dart';

import '../../controller/storage/storage_controller.dart';
import '../../utils/other/style/style_methods.dart';
import '../info/info_page.dart';
import '../top_bar/custom_top_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int activeCarouselPageIndex = 0;
  bool showingProgress = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: SafeArea(
            child: showingProgress ? YOLOLoadingPage() :
            Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/waves.png"),
                fit: BoxFit.cover,
              ),
            ),

            child: Column(
              children: [
            CustomTopBar(text: context.tr("welcome"), color: Colors.black, alignLeft: true),

            Padding(padding: EdgeInsets.all(getMinDimension(context) * 0.01),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                    elevation: 20,
                    child:
                    Container(
                      height: getHeight(context) * 0.25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white),
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 0, 0, 0),
                            Color.fromARGB(255, 61, 61, 61)
                          ],
                          begin: Alignment.topCenter,
                        ),
                      ),

                      child: Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: getWidth(context) * 0.05,
                              vertical: getHeight(context) * 0.05,
                            ),
                            child: AutoSizeText(
                                context.tr("home_page"),
                                textAlign: TextAlign.center,
                                maxLines: 4,
                                wrapWords: false,
                                minFontSize: 0,
                                style: getTextStyle(
                                    context, Colors.white,
                                    fontSize: getMinDimension(context) * 500
                                )
                            ),
                          )
                      ),
                    )
                ),

                SizedBox(
                  width: getWidth(context),
                  height: getHeight(context) - getHeight(context) * CustomNavigationBar.HEIGHT_PERCENTAGE - getHeight(context) * CustomTopBar.HEIGHT_PERCENTAGE - getHeight(context) * 0.35,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        getCustomRoundButton(
                          context,
                          'Wybierz zdjęcie',
                          Icons.image_rounded,

                          onPressedEvent: () async {
                            bool result = await preAnalysisController.getImageFromGallery();

                            if(!result) {
                              return;
                            }

                            setState(() {
                              showingProgress = true;
                            });

                            await Future.delayed(Duration(milliseconds: 100), () async {preAnalysisController.onImageFromGallery(context);});

                            setState(() {
                              showingProgress = false;
                            });
                          },

                          width: getWidth(context) * 0.25,
                          height: getHeight(context) - getHeight(context) * CustomNavigationBar.HEIGHT_PERCENTAGE - getHeight(context) * CustomTopBar.HEIGHT_PERCENTAGE - getHeight(context) * 0.6,
                        ),

                        SizedBox(width: getWidth(context) * 0.1),

                        getCustomRoundButton(
                          context,
                          'Prześlij zdjęcie',
                          Icons.camera_alt_rounded,
                          onPressedEvent: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                Builder(
                                  builder: (context) {
                                    if(storageController.shouldDisplayTutorial()) {
                                      return CameraTutorialPage();
                                    }
                                    return CameraPage();
                                  }
                                ),
                              )
                            );
                          },
                          width: getWidth(context) * 0.6,
                          height: getHeight(context) - getHeight(context) * CustomNavigationBar.HEIGHT_PERCENTAGE - getHeight(context) * CustomTopBar.HEIGHT_PERCENTAGE - getHeight(context) * 0.35,
                        ),
                      ],
                    )
                ),
              ],
            ),
            ),
          ]
            ),
          ),
        ),

      );
    }
}