import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/camera/camera_page.dart';
import 'package:flutter_application_1/utils/other/dimension_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

Widget getTopBar(BuildContext context, String text, {bool alignLeft = true}){
  return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black)),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 155, 176, 208),
            Color.fromARGB(255, 193, 173, 204),
            Color.fromARGB(255, 222, 177, 181),
            Color.fromARGB(255, 220, 194, 168),
          ],
          //stops: [0.2, 0.3, 0.4, 0.6],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child:
      Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(
                  getMinDimension(context) * 0.05),
              child:
              SizedBox(
                height: getHeight(context) * 0.06,
                child: Align(
                  alignment: alignLeft ? Alignment.centerLeft : Alignment.center,
                  child:
                  AutoSizeText(
                      text,
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      wrapWords: false,
                      minFontSize: 0,
                      style: getTextStyle(
                          context, Colors.black,
                          fontSize: getMinDimension(
                              context) * 0.5
                      )
                  ),
                ),
              ),
            ),
            // Positioned(
            //   bottom: 0,
            //   child:
            //   Divider(
            //       color: Colors.black,
            //       thickness: 2
            //   ),
            // )
          ]
      )
  );
}

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
      fontSize: getMinDimension(context) * fontSize,
      color: color,
      fontWeight: FontWeight.normal,
    ),
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

Widget customButton(BuildContext context, String text, IconData iconData, {onPressedEvent, double size = 1, double iconSizeMult = 0.15}) {
  return Column(
    children: [
      Container(
        width: getWidth(context) * size,
        height: getWidth(context) * size,
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
            //radius: 0.1,
            //begin: Alignment.topRight,
            //end: Alignment.bottomLeft,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              spreadRadius: 1,
              blurRadius: 50,
              offset: Offset(0, 0),
            ),
          ],
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: IconButton(
          icon: Icon(
            iconData,
            size: getHeight(context) * iconSizeMult,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          onPressed: onPressedEvent,
        ),
      ),

      //Text(text, style: TextStyle(fontWeight: FontWeight.normal)),
    ],
  );
}