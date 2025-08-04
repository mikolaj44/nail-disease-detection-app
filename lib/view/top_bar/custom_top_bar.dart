import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../utils/dimension_utils.dart';
import '../../utils/style_methods.dart';

class CustomTopBar extends StatelessWidget {
  static final double HEIGHT_PERCENTAGE = 0.11;

  final String text;
  final Color color;
  final bool alignLeft;

  const CustomTopBar({super.key, required this.color, required this.alignLeft, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: color)),
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
                padding: EdgeInsets.all(getMinDimension(context) * 0.05),
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
                            fontSize: getMinDimension(context) * 0.5
                        )
                    ),
                  ),
                ),
              ),
            ]
        )
    );
  }
}