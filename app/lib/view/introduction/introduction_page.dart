import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../utils/other/dimension_utils.dart';
import '../home/main_page.dart';

class IntroductionPage extends StatefulWidget {
  int pageIndex = 0;

  IntroductionPage({this.pageIndex = 0, super.key});

  @override
  IntroductionPageState createState() => IntroductionPageState();
}

class IntroductionPageState extends State<IntroductionPage> {
  TextStyle getTextStyle(Color color, {double fontSize = 0.025, bool omitFontSize = false}) {
    if(omitFontSize){
      return GoogleFonts.getFont(
        'DM Serif Text',
        textStyle: TextStyle(
          color: color,
          fontWeight: FontWeight.normal,
        ),
      );
    }
    return GoogleFonts.getFont(
      'DM Serif Text',
      textStyle: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      widget.pageIndex = index;
                    });
                  }
              ),
              items: getInstructionSliders(context),
            ),

            SizedBox(height: getHeight(context) * 0.02),

            AnimatedSmoothIndicator(
              activeIndex: widget.pageIndex,
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
                            "Witamy w naszej aplikacji!",
                            textAlign: TextAlign.left,
                            maxLines: 2,
                              wrapWords: false,
                              minFontSize: 0,
                            style: getTextStyle(Color.fromARGB(255, 255, 255, 255), fontSize: getMinDimension(context) * 0.3)
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
                              "Nasza aplikacja służy do analizy płytki paznokcia w celu wstępnego wykrycia chorób, które następnie można skonsultować z profesjonalistą.",
                              textAlign: TextAlign.left,
                              //maxLines: 15,
                              wrapWords: false,
                              minFontSize: 0,
                              style: getTextStyle(
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
                              "Całkowicie za darmo, bez logowania i w kilka chwil możesz otrzymać przydatną poradę.",
                              textAlign: TextAlign.left,
                              //maxLines: 5,
                              wrapWords: false,
                              minFontSize: 0,
                              style: getTextStyle(Color.fromARGB(255, 255, 255, 255), fontSize: getMinDimension(context) * 60)
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
                              "Przewiń dalej, aby dowiedzieć się więcej!",
                              textAlign: TextAlign.left,
                              //maxLines: 5,
                              wrapWords: false,
                              minFontSize: 0,
                              style: getTextStyle(Color.fromARGB(255, 255, 255, 255), fontSize: getMinDimension(context) * 60)
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
                              "Polityka prywatności",
                              textAlign: TextAlign.left,
                              minFontSize: 0,
                              wrapWords: false,
                              maxLines: 2,
                              style: getTextStyle(Color.fromARGB(255, 255, 255, 255), fontSize: getMinDimension(context) * 0.3)
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
                              "To nie żart! Nie zbieramy żadnych Twoich danych osobowych:",
                              textAlign: TextAlign.left,
                              wrapWords: false,
                              minFontSize: 0,
                              style: getTextStyle(Color.fromARGB(255, 255, 255, 255), fontSize: getMinDimension(context) * 60)
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
                              "- Nie jest wymagane połączenie z Internetem:",
                              textAlign: TextAlign.left,
                              wrapWords: false,
                              minFontSize: 0,
                              style: getTextStyle(Color.fromARGB(255, 255, 255, 255), fontSize: getMinDimension(context) * 60)
                          ),
                        ),
                      ),
                      //SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                      SizedBox(
                        height: getHeight(context) * 0.1,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: AutoSizeText(
                              "Analiza dokonywana jest lokalnie, za pomocą modeli szybkiego rozpoznawania obrazu.",
                              textAlign: TextAlign.left,
                              wrapWords: false,
                              minFontSize: 0,
                              style: getTextStyle(Color.fromARGB(255, 255, 255, 255), fontSize: getMinDimension(context) * 60)
                          ),
                        ),
                      ),
                      Divider(thickness: 2),
                      SizedBox(
                        height: getHeight(context) * 0.15,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: AutoSizeText(
                              "- Nie jest wymagane logowanie, a Twoje dane nie są nigdzie zapisywane:",
                              textAlign: TextAlign.left,
                              wrapWords: false,
                              minFontSize: 0,
                              style: getTextStyle(Color.fromARGB(255, 255, 255, 255), fontSize: getMinDimension(context) * 60)
                          ),
                        ),
                      ),
                      //SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                      SizedBox(
                        height: getHeight(context) * 0.1,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: AutoSizeText(
                              "Jeśli masz wątpliwości, to kod całej aplikacji możesz znaleźć na naszym GitHubie, szczegółów szukaj w aplikacji",
                              textAlign: TextAlign.left,
                              minFontSize: 0,
                              style: getTextStyle(Color.fromARGB(255, 255, 255, 255), fontSize: getMinDimension(context) * 60)
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
                              "Końcowe uwagi",
                              textAlign: TextAlign.center,
                              wrapWords: false,
                              minFontSize: 0,
                              maxLines: 2,
                              style: getTextStyle(Color.fromARGB(255, 255, 255, 255), fontSize: getMinDimension(context) * 60)
                          ),
                        ),
                      ),
                      Divider(thickness: 2),
                      SizedBox(
                        height: getHeight(context) * 0.3,
                        child: Align(
                          alignment: Alignment.center,
                          child: AutoSizeText(
                              "Pamiętaj, że uzyskana diagnoza jest jedynie wskazówką, prawdziwe wyniki uzyskasz u dermatologa - nasza aplikacja stanowi jedynie pomoc w wykryciu choroby, nie ponosimy odpowiedzialności za nieodpowiednie wyniki.",
                              textAlign: TextAlign.left,
                              wrapWords: false,
                              minFontSize: 0,
                              style: getTextStyle(Color.fromARGB(255, 255, 255, 255), fontSize: getMinDimension(context) * 60)
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
                                            secondaryAnimation) => const MainPage(),
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
                                        "Przejdź do aplikacji",
                                        textAlign: TextAlign.left,
                                        wrapWords: false,
                                        minFontSize: 0,
                                        style: getTextStyle(Color.fromARGB(255, 255, 255, 255), fontSize: 10000)
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