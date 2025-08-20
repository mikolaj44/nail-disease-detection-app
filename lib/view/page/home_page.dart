import 'package:flutter_application_1/utils/style_methods.dart';
import 'package:flutter_application_1/view/info_popup/info_popup.dart';
import 'package:flutter_application_1/view/bar/top_bar/custom_top_bar.dart';
import 'package:flutter_application_1/controller/image_analysis/image_analysis_controller.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/view/page/camera/camera_page.dart';
import 'package:flutter_application_1/utils/dimension_utils.dart';
import 'package:flutter_application_1/view/introduction/camera_tutorial_page.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int activeCarouselPageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ImageAnalysisController>(
      builder: (context, analysis, child) {
        return Scaffold(
          body:
              imageAnalysisController.isLoadingImage
                  ? YOLOLoadingPopup(
                    transparentBackground: false,
                    widthPercentage: 0.8,
                    heightPercentage: 0.6,
                  )
                  : Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/waves.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      children: [
                        CustomTopBar(
                          heightPercentage: 0.11,
                          text: context.tr("welcome"),
                          color: Colors.black,
                          alignLeft: true,
                        ),
                        Card(
                          elevation: 20,
                          child: Container(
                            height: getHeight(context) * 0.25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.white),
                              gradient: const LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 0, 0, 0),
                                  Color.fromARGB(255, 61, 61, 61),
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
                                    context,
                                    Colors.white,
                                    fontSize: getMinDimension(context) * 500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    getCustomRoundButton(
                                      context,
                                      'Wybierz zdjęcie',
                                      Icons.image_rounded,

                                      onPressedEvent: () async {
                                        await imageAnalysisController.onGalleryChosen(context);
                                      },

                                      width: getWidth(context) / 3,
                                      height: getHeight(context) / 3,
                                    ),

                                    // SizedBox(width: getWidth(context) * 0.1),

                                    getCustomRoundButton(
                                      context,
                                      'Prześlij zdjęcie',
                                      Icons.camera_alt_rounded,
                                      onPressedEvent: () {
                                        Navigator.of(context).push(
                                          PageRouteBuilder(
                                            opaque: false,
                                            pageBuilder:
                                                (context, animation, builder) =>
                                                    Builder(
                                                      builder: (context) {
                                                        if (storageController.shouldDisplayTutorial()) {
                                                          return CameraTutorialPage();
                                                        }
                                                        return CameraPage();
                                                      },
                                                ),
                                          ),
                                        );
                                      },
                                      width: getWidth(context) / 1.5,
                                      height: getHeight(context) / 1.5,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
        );
      },
    );
  }
}
