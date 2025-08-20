import 'package:flutter_application_1/view/bar/top_bar/custom_top_bar.dart';
import 'package:flutter_application_1/utils/dimension_utils.dart';
import 'package:flutter_application_1/controller/other/url_launcher.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/utils/style_methods.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/waves.png"),
              fit: BoxFit.cover,
            ),
          ),

          child: Column(
            children: [
              CustomTopBar(
                heightPercentage: 0.11,
                text: context.tr("info"),
                color: Colors.black,
                alignLeft: false,
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(getMinDimension(context) * 0.05),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black),
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
                        child: Padding(
                          padding: EdgeInsets.all(
                            getMinDimension(context) * 0.05,
                          ),
                          child: SizedBox(
                            height: getHeight(context) * 0.2,
                            width: getWidth(context),
                            child: Align(
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Flexible(
                                            child: SizedBox(
                                              height: getHeight(context) * 0.15,
                                              width: getWidth(context) * 0.5,
                                              child: AutoSizeText(
                                                context.tr("info_1"),
                                                textAlign: TextAlign.center,
                                                maxLines: 2,
                                                wrapWords: false,
                                                minFontSize: 0,
                                                style: getTextStyle(
                                                  context,
                                                  Colors.black,
                                                  fontSize: getMinDimension(context) * 500,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            child: MouseRegion(
                                              cursor: SystemMouseCursors.click,
                                              child: GestureDetector(
                                                onTap: () async {
                                                  UrlLauncher.launchUrl(
                                                    repositoryUrl,
                                                  );
                                                },
                                                child: Card(
                                                  elevation: 5,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      border: Border.all(color: Colors.black),
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

                                                    child: Align(
                                                      alignment: Alignment.center,
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                              horizontal: getWidth(context) * 0.025,
                                                              vertical: getHeight(context) * 0.025,
                                                            ),
                                                        child: AutoSizeText(
                                                          repositoryUrl,
                                                          textAlign: TextAlign.center,
                                                          maxLines: 2,
                                                          wrapWords: true,
                                                          minFontSize: 0,
                                                          style: getTextStyle(
                                                            context,
                                                            Colors.black,
                                                            fontSize: getMinDimension(context) * 500,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
