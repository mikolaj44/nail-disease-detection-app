import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/view/camera/camera_page.dart';
import 'package:flutter_application_1/utils/other/dimension_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../controller/page_switching/page_switching_controller.dart';
import '../../controller/storage/storage_controller.dart';
import '../../utils/other/style/style_methods.dart';
import 'custom_navigation_bar_button.dart';

class CustomNavigationBar extends StatelessWidget {
  static final double HEIGHT_PERCENTAGE = 0.12;

  final List<CustomNavigationBarButton> buttons;

  const CustomNavigationBar({super.key, required this.buttons});

  @override
  Widget build(BuildContext context){
    return Consumer<PageSwitchingController>(
        builder: (context, analysis, child) {
          return Stack(
              children: [
                Container(
                  width: getWidth(context),
                  height: getHeight(context) * CustomNavigationBar.HEIGHT_PERCENTAGE,
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
                  child: Row(
                    children: buttons,
                  ),
                )
              ]
          );
        });
  }
}