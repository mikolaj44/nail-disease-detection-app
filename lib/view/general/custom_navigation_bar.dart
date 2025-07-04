import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/camera/camera_page.dart';
import 'package:flutter_application_1/utils/other/dimension_utils.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/page_switching/page_switching_controller.dart';
import '../../controller/storage/storage_controller.dart';
import '../../utils/other/style/style_methods.dart';

class CustomNavigationBar extends StatefulWidget{
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => CustomNavigationBarState();
}

class CustomNavigationBarState extends State<CustomNavigationBar> {
  @override
  Widget build(BuildContext context){
    return Stack(
    children: [
      Container(
        width: getWidth(context),
        height: getHeight(context) * 0.15,
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 20, 20, 20),
                  Color.fromARGB(255, 30, 30, 30),
                  Color.fromARGB(255, 40, 40, 40)
                ],
                begin: Alignment.topCenter,
                //stops: [0.25, 0.4, 0.6]
              ),
            ),
      ),
      Material(
        color: Colors.transparent,
        child: Row(children: [
          InkWell(
            splashColor: Colors.black.withOpacity(0.3),
            highlightColor: Colors.black.withOpacity(0.3),
            onTap: () => PageSwitchingController.setActivePage(context, ActivePage.SETTINGS_PAGE),
            child: SizedBox(
                width: getWidth(context) / 3,
                height: getHeight(context) * 0.15,
                child: Icon(
                  Icons.settings_accessibility_rounded,
                  color: Colors.white60,
                  size: getMinDimension(context) / 10,
                )
            ),
          ),
          InkWell(
            splashColor: Colors.black.withOpacity(0.3),
            highlightColor: Colors.black.withOpacity(0.3),
            onTap: () => PageSwitchingController.setActivePage(context, ActivePage.MAIN_PAGE),
            child: SizedBox(
                width: getWidth(context) / 3,
                height: getHeight(context) * 0.15,
                child: Icon(
                  Icons.home_rounded,
                  color: Colors.white60,
                  size: getMinDimension(context) / 10,
                )
            ),
          ),
          InkWell(
            splashColor: Colors.black.withOpacity(0.3),
            highlightColor: Colors.black.withOpacity(0.3),
            onTap: () => PageSwitchingController.setActivePage(context, ActivePage.INFO_PAGE),
            child: SizedBox(
                width: getWidth(context) / 3,
                height: getHeight(context) * 0.15,
                child: Icon(
                  Icons.contact_support_rounded,
                  color: Colors.white60,
                  size: getMinDimension(context) / 10,
                )
            ),
          )
        ])
    )
    ]
    );
  }
}