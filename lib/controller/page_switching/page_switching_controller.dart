import 'package:flutter/material.dart';

import '../../utils/simple_methods.dart';
import '../../view/navigation_bar/custom_navigation_bar_button.dart';
import '../../view/navigation_bar/custom_navigation_bar.dart';

class PageSwitchingController with ChangeNotifier {
  List<Widget> pages = [];
  int activePageIndex = 1;
  Offset transitionOffset = Offset(1,0);
  final CustomNavigationBar customNavigationBar;

  PageSwitchingController({required this.customNavigationBar}){
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

    for (int i = 0; i < pages.length; i++) {
      if (i == index) {
        customNavigationBar.buttons[i] = CustomNavigationBarButton(switchWidget: customNavigationBar.buttons[i].switchWidget, iconData: customNavigationBar.buttons[i].iconData, iconColor: Colors.white);
      }
      else {
        customNavigationBar.buttons[i] = CustomNavigationBarButton(switchWidget: customNavigationBar.buttons[i].switchWidget, iconData: customNavigationBar.buttons[i].iconData, iconColor: Colors.white60);
      }
    }

    notifyListeners();
  }
}