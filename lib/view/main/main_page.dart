import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/page_switching/page_switching_controller.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/view/top_bar/custom_top_bar.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/view/camera/camera_page.dart';
import 'package:flutter_application_1/utils/other/dimension_utils.dart';
import 'package:flutter_application_1/view/home/home_page.dart';
import 'package:flutter_application_1/view/navigation_bar/custom_navigation_bar.dart';

import '../../controller/storage/storage_controller.dart';
import '../../utils/other/style/style_methods.dart';
import '../info/info_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageSwitchingController>(
        builder: (context, analysis, child) {
      return SafeArea(
          child: Scaffold(
            body: SizedBox.expand(
              child: Stack (
                  children: [
                      SizedBox(
                        height: getHeight(context) - CustomNavigationBar.HEIGHT_PERCENTAGE * getHeight(context),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                            child: pageSwitchingController.getActivePage(),
                          // transitionBuilder: (Widget child, Animation<double> animation) {
                          //   final tween = Tween<Offset>(
                          //     begin: pageSwitchingController.transitionOffset,
                          //     end:  Offset.zero
                          //   );
                          //
                          //   return SlideTransition(position: animation.drive(tween), child: child);
                          // },
                        ),
                      ),
                    Positioned(
                        bottom: 0,
                        child: customNavigationBar
                    )
                  ],
                ),
            ),
          )
      );
    });
  }
}