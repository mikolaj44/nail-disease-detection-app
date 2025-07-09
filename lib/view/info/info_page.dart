import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/view/camera/camera_page.dart';
import 'package:flutter_application_1/utils/other/dimension_utils.dart';
import 'package:flutter_application_1/view/navigation_bar/custom_navigation_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/storage/storage_controller.dart';
import '../../utils/other/style/style_methods.dart';
import '../top_bar/custom_top_bar.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
        body: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomTopBar(text: context.tr("info"), color: Colors.black, alignLeft: false),
            Container(
              height: getHeight(context),
              width: getWidth(context),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("resources/waves.png"),
                  fit: BoxFit.cover,
                ),
              ),
            child: RichText(
                  text: TextSpan(
                    style: getTextStyle(context, Color.fromARGB(255, 0, 0, 0)),
                    children: [
                      // TextSpan(
                      //   text: 'Nasza aplikacja',
                      //   style: TextStyle(fontWeight: FontWeight.bold),
                      // ),
                      // TextSpan(
                      //   text:
                      //   ' służy do wczesnego diagnozowania chorób paznokci. Udziela jedynie porad, które mogą być podstawą wizyty u dermatologa.',
                      // ),
                      //
                      // TextSpan(
                      //   text: '\n\nZdjęcia, które zrobisz',
                      //   style: TextStyle(fontWeight: FontWeight.bold),
                      // ),
                      // TextSpan(
                      //   text:
                      //   ', nie będą przechowywane w żadnej bazie danych - kod jest dostępny publicznie. Pamiętaj, żeby były dobrze oświetlone i zrobione od góry.',
                      // ),
                      //
                      // TextSpan(
                      //   text: '\n\nWięcej informacji',
                      //   style: TextStyle(fontWeight: FontWeight.bold),
                      // ),
                      // TextSpan(
                      //   text:
                      //   ' uzyskasz na naszym Githubie: xyz.github.com - projekt realizowany w ramach koła naukowego "Praktyka".',
                      // ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      )
    );
  }
}