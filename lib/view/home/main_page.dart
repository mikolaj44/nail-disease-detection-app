import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
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
      body: SafeArea(
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
              Stack(
    children: [
              Column(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      getTopBar(context, context.tr("welcome"), alignLeft: true),

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
                                storageController.getLocalFile();
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
    ],
              ),

      Positioned(
          bottom: 0,
          child: CustomNavigationBar()
      ),
        ]
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
