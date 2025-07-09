import 'package:auto_size_text/auto_size_text.dart';
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
              width: getWidth(context),
              height: getHeight(context) - CustomNavigationBar.HEIGHT_PERCENTAGE * getHeight(context) - CustomTopBar.HEIGHT_PERCENTAGE * getHeight(context),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("resources/waves.png"),
                  fit: BoxFit.cover,
                ),
              ),
              // child: AutoSizeText(
              //   "info text will be here",
              //   textAlign: TextAlign.center,
              //   maxLines: 4,
              //   wrapWords: false,
              //   minFontSize: 0,
              //   style: getTextStyle(
              //       context, Colors.black,
              //       fontSize: getMinDimension(context) * 0.001
              //   )
              // ),
            ),
            ]
        ),
      )
    );
  }
}