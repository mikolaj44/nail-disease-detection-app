import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_application_1/view/top_bar/custom_top_bar.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/view/camera/camera_page.dart';
import 'package:flutter_application_1/utils/other/dimension_utils.dart';
import 'package:flutter_application_1/view/navigation_bar/custom_navigation_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/other/url_launcher.dart';
import '../../controller/storage/storage_controller.dart';
import '../../main.dart';
import '../../utils/other/style/style_methods.dart';
import '../home/home_page.dart';

typedef MenuEntry = DropdownMenuEntry<String>;

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              height: getHeight(context) - getHeight(context) * CustomNavigationBar.HEIGHT_PERCENTAGE,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("resources/waves.png"),
                  fit: BoxFit.cover,
                ),
              ),

              child: Column(
                  children: [
                    CustomTopBar(text: context.tr("info"), color: Colors.black, alignLeft: false),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(
                            getMinDimension(context) * 0.05,
                          ),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 155, 176, 208),
                                    Color.fromARGB(255, 193, 173, 204),
                                    Color.fromARGB(255, 222, 177, 181),
                                    Color.fromARGB(255, 220, 194, 168),
                                  ],
                                  //stops: [0.2, 0.3, 0.4, 0.6],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(
                                  getMinDimension(context) * 0.05,
                                ),
                                child: SizedBox(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          height: getHeight(context) * 0.2,
                                          width: getWidth(context) - getWidth(context) * 0.2,
                                          child: Align(
                                            alignment: Alignment.center,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Flexible(
                                                    child: AutoSizeText(
                                                        context.tr("info_1"),
                                                        textAlign: TextAlign.left,
                                                        maxLines: 2,
                                                        wrapWords: false,
                                                        minFontSize: 0,
                                                        style: getTextStyle(
                                                            context,
                                                            Colors.black,
                                                            fontSize: getMinDimension(context) * 500
                                                        )
                                                    ),
                                                  ),
                                                    Flexible(
                                                    child: MouseRegion(
                                                      cursor: SystemMouseCursors.click,
                                                        child: GestureDetector(
                                                          onTap: () async {
                                                            UrlLauncher.launchUrl(
                                                                REPOSITORY_URL);
                                                          },
                                                          child: Card(
                                                              elevation: 5,
                                                              child:
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(10),
                                                                  border: Border.all(color: Colors.black),
                                                                  gradient: const LinearGradient(
                                                                    colors: [
                                                                      Color.fromARGB(
                                                                        255,
                                                                        155,
                                                                        176,
                                                                        208,
                                                                      ),
                                                                      Color.fromARGB(
                                                                        255,
                                                                        193,
                                                                        173,
                                                                        204,
                                                                      ),
                                                                      Color.fromARGB(
                                                                        255,
                                                                        222,
                                                                        177,
                                                                        181,
                                                                      ),
                                                                      Color.fromARGB(
                                                                        255,
                                                                        220,
                                                                        194,
                                                                        168,
                                                                      ),
                                                                    ],
                                                                    //stops: [0.2, 0.3, 0.4, 0.6],
                                                                    begin: Alignment.centerLeft,
                                                                    end: Alignment.centerRight,
                                                                  ),
                                                                ),

                                                                child: Align(
                                                                    alignment: Alignment.center,
                                                                    child: Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                        horizontal: getWidth(context) * 0.025,
                                                                        vertical: getHeight(context) * 0.025,
                                                                      ),
                                                                      child: AutoSizeText(
                                                                        REPOSITORY_URL,
                                                                        textAlign: TextAlign
                                                                            .center,
                                                                        maxLines: 2,
                                                                        wrapWords: true,
                                                                        minFontSize: 0,
                                                                        style: getTextStyle(
                                                                            context,
                                                                            Colors.black,
                                                                            fontSize: getMinDimension(
                                                                                context) *
                                                                                500)
                                                                      ),
                                                                    )
                                                                ),
                                                              )
                                                          ),
                                                      )
                                                  ),
                                                  ),
                                                ],
                                            )
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: getHeight(context) * CustomNavigationBar.HEIGHT_PERCENTAGE,
                    ),
                  ],
                ),
            ),
          ),
        );
  }
}
