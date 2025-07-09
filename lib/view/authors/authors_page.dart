import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/view/camera/camera_page.dart';
import 'package:flutter_application_1/utils/other/dimension_utils.dart';
import 'package:flutter_application_1/view/navigation_bar/custom_navigation_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/storage/storage_controller.dart';
import '../../utils/other/style/style_methods.dart';

class AuthorsPage extends StatelessWidget {
  const AuthorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Informacje o autorach',
          style: getTextStyle(context, Color.fromARGB(255, 0, 0, 0), fontSize: 0.03),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: getHeight(context) * 0.1),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth(context) * 0.05),
            child: RichText(
              text: TextSpan(
                style: getTextStyle(context, Color.fromARGB(255, 0, 0, 0)),
                children: [
                  TextSpan(
                    text: 'Autorzy projektu:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' tutaj pojawią się autorzy projektu.'),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
