import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/camera/camera_page.dart';
import 'package:flutter_application_1/utils/other/dimension_utils.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/storage/storage_controller.dart';
import '../../utils/other/style/style_methods.dart';
import '../../view/home/main_page.dart';
import '../../view/info/info_page.dart';
import "../../view/settings/settings_page.dart";

enum ActivePage {
  SETTINGS_PAGE,
  MAIN_PAGE,
  INFO_PAGE
}

class PageSwitchingController {
  static ActivePage activePage = ActivePage.MAIN_PAGE;

  static void setActivePage(BuildContext context, ActivePage newPage){
    Widget? switchWidget;
    Offset? slideBeginOffset;
    
    // TODO: refactor this, probably a list of classes and use reflection, this method should probably just take an index of next page

    switch(newPage){
      case ActivePage.SETTINGS_PAGE:
        switch(activePage){
          case ActivePage.SETTINGS_PAGE:
            return;
          case ActivePage.INFO_PAGE:
            slideBeginOffset = Offset(1, 0);
          case ActivePage.MAIN_PAGE:
            slideBeginOffset = Offset(-1, 0);
          default:
            return;
        }
        switchWidget = SettingsPage();
      case ActivePage.MAIN_PAGE:
        switch(activePage){
          case ActivePage.MAIN_PAGE:
            return;
          case ActivePage.INFO_PAGE:
            slideBeginOffset = Offset(1, 0);
          case ActivePage.SETTINGS_PAGE:
            slideBeginOffset = Offset(-1, 0);
          default:
            return;
        }
        switchWidget = MainPage();
      case ActivePage.INFO_PAGE:
        switch(activePage){
          case ActivePage.INFO_PAGE:
            return;
          case ActivePage.MAIN_PAGE:
            slideBeginOffset = Offset(1, 0);
          case ActivePage.SETTINGS_PAGE:
            slideBeginOffset = Offset(-1, 0);
          default:
            return;
        }
        switchWidget = InfoPage();
      default:
        return;
    }

    activePage = newPage;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => switchWidget!),
      (Route<dynamic> route) => false,
    );
  }
}