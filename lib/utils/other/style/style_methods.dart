import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/view/camera/camera_page.dart';
import 'package:flutter_application_1/utils/other/dimension_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

TextStyle getTextStyle(BuildContext context, Color color, {double fontSize = 0.025, bool omitFontSize = false}) {
  return GoogleFonts.domine(
      color: color,
      fontSize: omitFontSize ? 14.0 : getMinDimension(context) * fontSize,
      fontWeight: FontWeight.w700
  );
}

// RouteTransitionsBuilder getSlideTransition(Offset beginOffset) {
//   return (context, animation, secondaryAnimation, child) {
//     const end = Offset.zero;
//     final tween = Tween(begin: beginOffset, end: end);
//     final offsetAnimation = animation.drive(tween);
//
//     return SlideTransition(position: offsetAnimation, child: child);
//   };
// }

Widget getCustomRoundButton(BuildContext context, String text, IconData iconData, {required onPressedEvent, required double width, required double height}) {
  return Container(
    width: min(width, height),
    height: min(width, height),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: const SweepGradient(
        colors: [
          Color.fromARGB(255, 209, 178, 146),
          Color.fromARGB(255, 220, 171, 175),
          Color.fromARGB(255, 193, 173, 204),
          //Color.fromARGB(255, 155, 176, 208),
          Color.fromARGB(255, 209, 178, 146),
        ],
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.white,
          spreadRadius: 0.1,
          blurRadius: 10,
        ),
      ],
      border: Border.all(color: Colors.white, width: 2),
    ),
    child: IconButton(
      iconSize: min(width, height) * 0.5,
      icon: Icon(
        iconData,
        size: min(width, height) * 0.5,
        color: Color.fromARGB(255, 255, 255, 255),
      ),
      onPressed: onPressedEvent,
      style: IconButton.styleFrom(
        shape: CircleBorder(),
        splashFactory: InkRipple.splashFactory,
      ),
    ),
  );
}