import 'custom_navigation_bar_button.dart';
import 'package:flutter_application_1/utils/dimension_utils.dart';

import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  final double heightPercentage;

  final List<CustomNavigationBarButton> buttons;

  const CustomNavigationBar({super.key, required this.buttons, required this.heightPercentage});

  @override
  Widget build(BuildContext context) {
          return Stack(
              children: [
                Container(
                  width: getWidth(context),
                  height: getHeight(context) * heightPercentage,
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
  }
}