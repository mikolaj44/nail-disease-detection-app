library;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/storage/storage_controller.dart';
import 'package:flutter_application_1/view/camera/camera_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../utils/other/dimension_utils.dart';
import '../../utils/other/style/style_methods.dart';
import '../home/home_page.dart';
import '../main/main_page.dart';

part "no_detections_popup.dart";

abstract class InfoPopup extends StatelessWidget {
  final bool transparentBackground;
  final double widthPercentage;
  final double heightPercentage;

  const InfoPopup({super.key, required this.transparentBackground, required this.widthPercentage, required this.heightPercentage});

  @override
  Widget build(BuildContext context) {
    if (transparentBackground) {
      return _getContent(context);
    }
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/waves.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: _getContent(context)
    );
  }

  List<Widget> _getContentItems(BuildContext context);

  List<Widget> _getButtons(BuildContext context);

  List<Widget> _getItems(BuildContext context){
    List<Widget> items = _getContentItems(context);

    items.addAll(_getButtons(context));

    return items;
  }

  Widget _getContent(BuildContext context){
    return Align(
        alignment: Alignment.center,
        child: Card(
            elevation: 20,
            child:
            Container(
                width: getWidth(context) * widthPercentage,
                height: getHeight(context) * heightPercentage,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white),
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 0, 0, 0),
                      Color.fromARGB(255, 61, 61, 61)
                    ],
                    begin: Alignment.topCenter,
                  ),
                ),

                child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getWidth(context) * 0.05,
                      vertical: getHeight(context) * 0.05,
                    ),
                    child: Column(
                      children: _getItems(context)
                    )
                )
            )
        )
    );
  }
}


class InfoButton extends StatelessWidget {
  final String translationEntry;
  final Widget pageToGo;
  final double widthPercentage;
  final double heightPercentage;

  const InfoButton({super.key, required this.translationEntry, required this.pageToGo, required this.widthPercentage, required this.heightPercentage});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black, width: 2),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 6, 6, 6),
            Color.fromARGB(255, 61, 61, 61)
          ],
          begin: Alignment.bottomCenter,
        ),
      ),

      width: getWidth(context) * widthPercentage,
      height: getHeight(context) * heightPercentage,

      child: TextButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => pageToGo,
              //transitionsBuilder: getSlideTransition(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
                color: Colors.white
            ),
          ),
          foregroundColor: Colors.transparent,
          side: BorderSide(
              color: Colors.white
          ),
        ),

        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getWidth(context) * 0.04,
            vertical: getHeight(context) * 0.03,
          ),
          child: Align(
            alignment: Alignment.center,
            child: AutoSizeText(
                translationEntry,
                textAlign: TextAlign.center,
                wrapWords: false,
                minFontSize: 0,
                style: getTextStyle(context, Color.fromARGB(255, 255, 255, 255), fontSize: 10000)
            ),
          ),
        ),
      ),
    );
  }
}