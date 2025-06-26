import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/camera/camera_page.dart';
import 'package:flutter_application_1/utils/other/dimension_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

TextStyle getTextStyle(BuildContext context, Color color, {double fontSize = 0.025, bool omitFontSize = false}) {
  if(omitFontSize){
    return GoogleFonts.getFont(
      'DM Serif Text',
      textStyle: TextStyle(
        color: color,
        fontWeight: FontWeight.normal,
      ),
    );
  }
  return GoogleFonts.getFont(
    'DM Serif Text',
    textStyle: TextStyle(
      fontSize: MediaQuery.of(context).size.height * fontSize,
      color: color,
      fontWeight: FontWeight.normal,
    ),
  );
}

RouteTransitionsBuilder getSlideTransition() {
  return (context, animation, secondaryAnimation, child) {
    const begin = Offset(0.0, 1.0);
    const end = Offset.zero;
    final tween = Tween(begin: begin, end: end);
    final offsetAnimation = animation.drive(tween);

    return SlideTransition(position: offsetAnimation, child: child);
  };
}

