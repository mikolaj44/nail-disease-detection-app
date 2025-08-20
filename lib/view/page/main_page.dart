import 'info_page.dart';
import 'settings_page.dart';

import 'package:flutter_application_1/controller/page_switching/page_switching_controller.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/view/page/home_page.dart';
import 'package:flutter_application_1/view/bar/navigation_bar/custom_navigation_bar.dart';
import 'package:flutter_application_1/view/bar/navigation_bar/custom_navigation_bar_button.dart';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

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
           body: Column (
                  children: [
                      Expanded(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: [SettingsPage(), HomePage(), InfoPage()][pageSwitchingController.getActivePageIndex()],
                        ),
                      ),
                        CustomNavigationBar(
                            heightPercentage: 0.12,
                            buttons: [
                              CustomNavigationBarButton(
                                  switchWidgetIndex: 0,
                                  iconData: Icons.accessibility_rounded,
                                  iconColor: Colors.white60
                              ),
                              CustomNavigationBarButton(
                                  switchWidgetIndex: 1,
                                  iconData: Icons.home_rounded,
                                  iconColor: Colors.white60
                              ),
                              CustomNavigationBarButton(
                                  switchWidgetIndex: 2,
                                  iconData: Icons.contact_support_rounded,
                                  iconColor: Colors.white60
                              )
                            ]
                        )
                  ],
                ),
            ),
      );
    });
  }
}