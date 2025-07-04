import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/camera/camera_page.dart';
import 'package:flutter_application_1/utils/other/dimension_utils.dart';
import 'package:flutter_application_1/view/general/custom_navigation_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/storage/storage_controller.dart';
import '../../utils/other/style/style_methods.dart';
import '../info/info_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int activeCarouselPageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        //title: const Text('Aplikacja do diagnozy paznokci'),
        backgroundColor:
        Colors.white, //const Color.fromARGB(255, 237, 235, 235),

        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 220, 194, 168),
                //Color.fromARGB(255,222,177,181),
                //Color.fromARGB(255,193,173,204),
                Color.fromARGB(255, 155, 176, 208),
              ],
              //stops: [0.2, 0.3, 0.4, 0.6],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),

        //shape: Border(bottom: BorderSide(color: const Color.fromARGB(255, 255, 205, 205), width: 1)),
        title: Text(
          'Diagnozer paznokci',
          style: GoogleFonts.getFont(
            'DM Serif Text',
            fontWeight: FontWeight.bold,
            textStyle: getTextStyle(context, Color.fromARGB(255, 0, 0, 0)),
          ),
          textAlign: TextAlign.left,
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.language_rounded),
            color: Colors.black,
            onPressed: () {
              // Navigator.of(context).push(
              //   PageRouteBuilder(
              //     pageBuilder: (context, animation, secondaryAnimation) => const AuthorsPage(),
              //     transitionsBuilder: getSlideTransition(),
              //   ),
              // );
            },
          ),

          IconButton(
            icon: const Icon(Icons.question_mark_rounded),
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder:
                      (context, animation, secondaryAnimation) =>
                  const InfoPage(),
                  transitionsBuilder: getSlideTransition(Offset(0, 1)),
                ),
              );
            },
          ),

          IconButton(
            icon: const Icon(Icons.people),
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const AuthorsPage(),
                  transitionsBuilder: getSlideTransition(Offset(0, 1)),
                ),
              );
            },
          ),
        ],

        toolbarHeight: getHeight(context) * 0.09,
      ),

      body: Expanded(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("resources/waves.png"),
              fit: BoxFit.cover,
            ),
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 225, 224, 224),
              ],

              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),

          child:
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
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
                    vertical: getHeight(context) * 0.1,
                    // TODO: add some text
                  ),
                )
            ),
          )
      ),
      Align(
        alignment: Alignment.bottomCenter,
      child:
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,

              children: <Widget>[
                SizedBox(height: getHeight(context) * 0.03),

                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      SizedBox(height: getHeight(context) * 0.025),

                      Align(
                        alignment: Alignment.center,
                        child:
                        Row(
                          children: [
                            SizedBox(width: getWidth(context) * 0.07),

                            customButton(
                              context,
                              'Wybierz zdjęcie',
                              Icons.image_rounded,
                              onPressedEvent: () async {
                                StorageController.getLocalFile();
                              },
                              size: 0.3,
                              iconSizeMult: 0.1,
                            ),

                            SizedBox(width: getWidth(context) * 0.05),

                            customButton(
                              context,
                              'Prześlij zdjęcie',
                              Icons.camera_alt_rounded,
                              onPressedEvent: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CameraPage()),
                                );
                              },
                              size: 0.5,
                              iconSizeMult: 0.15,
                            ),
                          ],
                        ),
                      ),


                      SizedBox(height: getHeight(context) * 0.025),

                    ],
                  ),
                ),

                //SizedBox(height: getHeight(context) * 0.1),
              ],
            ),

            CustomNavigationBar()
          ]
      ),
      ),
    ],
              ),
              ),
          ),

    );
  }
}

class AuthorsPage extends StatelessWidget {
  const AuthorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Informacje o autorach',
          style: getTextStyle(context, Color.fromARGB(255, 0, 0, 0), fontSize: 0.03),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: getHeight(context) * 0.1),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth(context) * 0.05),
            child: RichText(
              text: TextSpan(
                style: getTextStyle(context, Color.fromARGB(255, 0, 0, 0)),
                children: [
                  TextSpan(
                    text: 'Autorzy projektu:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' tutaj pojawią się autorzy projektu.'),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
