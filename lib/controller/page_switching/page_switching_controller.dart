import 'package:flutter/material.dart';

import '../../utils/other/simple_methods.dart';
import '../../utils/other/style/style_methods.dart';
import '../../view/navigation_bar/custom_navigation_bar_button.dart';
import '../../view/navigation_bar/custom_navigation_bar.dart';

class PageSwitchingController with ChangeNotifier {
  List<Widget> pages = [];
  int activePageIndex = 1;
  Offset transitionOffset = Offset(1,0);

  PageSwitchingController({required CustomNavigationBar customNavigationBar}){
    for(CustomNavigationBarButton button in customNavigationBar.buttons){
      pages.add(button.switchWidget);
    }
  }

  Widget getActivePage(){
    return pages[activePageIndex];
  }

  void setActivePage({required BuildContext context, required Widget switchWidget}){
    int index = pages.indexOf(switchWidget);

    transitionOffset = Offset(sign(index - activePageIndex).toDouble(), 0);

    activePageIndex = index;

    notifyListeners();
  }
}