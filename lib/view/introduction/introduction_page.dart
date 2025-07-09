import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/storage/storage_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../utils/other/dimension_utils.dart';
import '../../utils/other/style/style_methods.dart';
import '../home/home_page.dart';

class IntroductionPage extends StatefulWidget {

  const IntroductionPage({super.key});

  @override
  IntroductionPageState createState() => IntroductionPageState();
}

class IntroductionPageState extends State<IntroductionPage> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("resources/waves.png"),
                fit: BoxFit.cover,
              ),
            ),
            child:
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(height: getHeight(context) * 0.06),

                  CarouselSlider(
                    options: CarouselOptions(
                        height: getHeight(context) * 0.86,
                        autoPlay: false,
                        aspectRatio: 2.0,
                        viewportFraction: 0.9,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            pageIndex = index;
                          });
                        }
                    ),
                    items: getInstructionSliders(context),
                  ),

                  SizedBox(height: getHeight(context) * 0.02),

                  AnimatedSmoothIndicator(
                    activeIndex: pageIndex,
                    count: 3,
                    effect: const WormEffect(
                        dotHeight: 12,
                        dotWidth: 12,
                        dotColor: Color.fromARGB(255, 230, 230, 230),
                        activeDotColor: Colors.black
                      //type: WormType.thinUnderground,
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  List<Widget> getInstructionSliders(BuildContext context) {
    return [
      Card(
          elevation: 20,
          child:
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
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
                child: Column(
                  children: [
                    SizedBox(
                      height: getHeight(context) * 0.1,
                      child: Align(
                        alignment: Alignment.topCenter,
                          child: AutoSizeText(
                            context.tr("welcome_title"),
                            textAlign: TextAlign.left,
                            maxLines: 2,
                              wrapWords: false,
                              minFontSize: 0,
                            style: getTextStyle(context, Color.fromARGB(255, 255, 255, 255), fontSize: getMinDimension(context) * 0.3)
                          ),
                      ),
                    ),
                    //SizedBox(height: 10),
                    Divider(thickness: 2),
                    //SizedBox(height: 10),
                    SizedBox(
                        height: getHeight(context) * 0.2,
                        child: Align(
                          alignment: Alignment.center,
                          child: AutoSizeText(
                              context.tr("welcome_1"),
                              textAlign: TextAlign.left,
                              //maxLines: 15,
                              wrapWords: false,
                              minFontSize: 0,
                              style: getTextStyle(context,
                                  Color.fromARGB(255, 255, 255, 255),
                                  fontSize: getMinDimension(context) * 60)
                          ),
                        )
                    ),
                    //SizedBox(height: getMinDimension(context) * 0.02),
                    Divider(thickness: 2),
                    //SizedBox(height: getMinDimension(context) * 0.02),
                    SizedBox(
                        height: getHeight(context) * 0.2,
                        child: Align(
                          alignment: Alignment.center,
                          child: AutoSizeText(
                              context.tr("welcome_2"),
                              textAlign: TextAlign.left,
                              //maxLines: 5,
                              wrapWords: false,
                              minFontSize: 0,
                              style: getTextStyle(context, Color.fromARGB(255, 255, 255, 255), fontSize: getMinDimension(context) * 60)
                          ),
                        )
                    ),
                    //SizedBox(height: getMinDimension(context) * 0.02),
                    Divider(thickness: 2),
                    //SizedBox(height: getMinDimension(context) * 0.02),
                    SizedBox(
                        height: getHeight(context) * 0.1,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: AutoSizeText(
                              context.tr("welcome_3"),
                              textAlign: TextAlign.left,
                              //maxLines: 5,
                              wrapWords: false,
                              minFontSize: 0,
                              style: getTextStyle(context, Color.fromARGB(255, 255, 255, 255), fontSize: getMinDimension(context) * 60)
                          ),
                        )
                    ),
                  ],
                )
              )
              ),
          )
      ),

      Card(
          elevation: 20,
          child:
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 0, 0, 0),
                    Color.fromARGB(255, 61, 61, 61)
                  ],
                  begin: Alignment.topCenter,
                ),
              ),

              child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getWidth(context) * 0.05,
                    vertical: getHeight(context) * 0.05,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: getHeight(context) * 0.1,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: AutoSizeText(
                              context.tr("privacy_policy_title"),
                              textAlign: TextAlign.left,
                              minFontSize: 0,
                              wrapWords: false,
                              maxLines: 2,
                              style: getTextStyle(context, Color.fromARGB(255, 255, 255, 255), fontSize: getMinDimension(context) * 0.3)
                          ),
                        ),
                      ),
                      //SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      Divider(thickness: 2),
                      //SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      SizedBox(
                        height: getHeight(context) * 0.07,
                        child: Align(
                          alignment: Alignment.center,
                          child: AutoSizeText(
                              context.tr("privacy_policy_1"),                              textAlign: TextAlign.left,
                              wrapWords: false,
                              minFontSize: 0,
                              style: getTextStyle(context, Color.fromARGB(255, 255, 255, 255), fontSize: getMinDimension(context) * 60)
                          ),
                        ),
                      ),
                      //SizedBox(height: MediaQuery.of(context).size.height * 0.02  ),
                      Divider(thickness: 2),
                      SizedBox(
                        height: getHeight(context) * 0.1,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: AutoSizeText(
                              context.tr("privacy_policy_2"),                              textAlign: TextAlign.left,
                              wrapWords: false,
                              minFontSize: 0,
                              style: getTextStyle(context, Color.fromARGB(255, 255, 255, 255), fontSize: getMinDimension(context) * 60)
                          ),
                        ),
                      ),
                      //SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                      SizedBox(
                        height: getHeight(context) * 0.1,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: AutoSizeText(
                              context.tr("privacy_policy_3"),
                              textAlign: TextAlign.left,
                              wrapWords: false,
                              minFontSize: 0,
                              style: getTextStyle(context, Color.fromARGB(255, 255, 255, 255), fontSize: getMinDimension(context) * 60)
                          ),
                        ),
                      ),
                      Divider(thickness: 2),
                      SizedBox(
                        height: getHeight(context) * 0.15,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: AutoSizeText(
                              context.tr("privacy_policy_4"),
                              textAlign: TextAlign.left,
                              wrapWords: false,
                              minFontSize: 0,
                              style: getTextStyle(context, Color.fromARGB(255, 255, 255, 255), fontSize: getMinDimension(context) * 60)
                          ),
                        ),
                      ),
                      //SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                      SizedBox(
                        height: getHeight(context) * 0.1,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: AutoSizeText(
                              context.tr("privacy_policy_5"),
                              textAlign: TextAlign.left,
                              minFontSize: 0,
                              style: getTextStyle(context, Color.fromARGB(255, 255, 255, 255), fontSize: getMinDimension(context) * 60)
                          ),
                        ),
                      ),
                      //SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    ],
                  )
              )
          )
      ),

      Card(
          elevation: 20,
          child:
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 0, 0, 0),
                    Color.fromARGB(255, 61, 61, 61)
                  ],
                  begin: Alignment.topCenter,
                ),
              ),

              child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getWidth(context) * 0.05,
                    vertical: getHeight(context) * 0.05,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: getHeight(context) * 0.1,
                        child: Align(
                          alignment: Alignment.center,
                          child: AutoSizeText(
                              context.tr("closing_remarks_title"),
                              textAlign: TextAlign.center,
                              wrapWords: false,
                              minFontSize: 0,
                              maxLines: 2,
                              style: getTextStyle(context, Color.fromARGB(255, 255, 255, 255), fontSize: getMinDimension(context) * 60)
                          ),
                        ),
                      ),
                      Divider(thickness: 2),
                      SizedBox(
                        height: getHeight(context) * 0.3,
                        child: Align(
                          alignment: Alignment.center,
                          child: AutoSizeText(
                              context.tr("closing_remarks_1"),
                              textAlign: TextAlign.left,
                              wrapWords: false,
                              minFontSize: 0,
                              style: getTextStyle(context, Color.fromARGB(255, 255, 255, 255), fontSize: getMinDimension(context) * 60)
                          ),
                        ),
                      ),
                      Divider(thickness: 2),


                        Align(
                            alignment: Alignment.center,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.black, width: 2),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 6, 6, 6),
                                    Color.fromARGB(255, 61, 61, 61)
                                  ],
                                  begin: Alignment.bottomCenter,
                                  tileMode: TileMode.mirror,
                                ),
                              ),

                              width: getWidth(context) * 0.5,
                              height: getHeight(context) * 0.1,

                              child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pushAndRemoveUntil(
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                            secondaryAnimation) => const HomePage(),
                                        //transitionsBuilder: getSlideTransition(),
                                      ),
                                          (Route<dynamic> route) => false,
                                    );
                                  },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  foregroundColor: Colors.grey,
                                ),

                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: getWidth(context) * 0.04,
                                    vertical: getHeight(context) * 0.03,
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: AutoSizeText(
                                        context.tr("go_to_app_button"),
                                        textAlign: TextAlign.left,
                                        wrapWords: false,
                                        minFontSize: 0,
                                        style: getTextStyle(context, Color.fromARGB(255, 255, 255, 255), fontSize: 10000)
                                    ),
                                  ),
                                ),
                              ),



                        ),
                        ),
                    ],
                  )
              )
          )
      )
    ];
  }
}