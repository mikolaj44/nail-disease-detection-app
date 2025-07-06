import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/view/camera/camera_page.dart';
import 'package:flutter_application_1/utils/other/dimension_utils.dart';
import 'package:flutter_application_1/view/general/custom_navigation_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/storage/storage_controller.dart';
import '../../main.dart';
import '../../utils/other/style/style_methods.dart';
import '../home/main_page.dart';

typedef MenuEntry = DropdownMenuEntry<String>;

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  final List<MenuEntry> menuEntries = UnmodifiableListView<MenuEntry>(
    languages.map<MenuEntry>((String name) => MenuEntry(value: name, label: name)),
  );

  @override
  Widget build(BuildContext context) {
    return Consumer<StorageController>(
        builder: (context, analysis, child)
    {
      return Scaffold(
        // appBar: AppBar(
        //   title: Text(
        //     'Ważne informacje',
        //     style: getTextStyle(context, Color.fromARGB(255, 0, 0, 0), fontSize: 0.03),
        //   ),
        //   backgroundColor: Colors.white,
        //   centerTitle: true,
        // ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
                children: [
                  SizedBox(height: getHeight(context) * 0.1),

                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Język: ", style: getTextStyle(context, Colors.black)),

                        SizedBox(height: getWidth(context) * 0.1),

                        DropdownMenu<String>(
                            initialSelection: languages.first,
                            onSelected: (String? value) {
                              // TODO: not finding the locale for some reason, also add translations
                              //context.setLocale(locales[languages.indexOf(value!)]);
                            },
                            dropdownMenuEntries: menuEntries,
                            textStyle: getTextStyle(context, Colors.black)
                        ),
                      ]
                  ),

                  SizedBox(height: getHeight(context) * 0.05),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(getMinDimension(context) * 0.1),
                          child:

                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: getHeight(context) * 0.1,
                                  child:
                                  Align(
                                    alignment: Alignment.center, child:
                                  Text("Pokazuj wprowadzenie: ", style: getTextStyle(context, Colors.black, fontSize: 0.015),
                                  ),),),
                                SizedBox(
                                  height: getHeight(context) * 0.1,
                                  child:
                                  Align(
                                    alignment: Alignment.center, child:
                                  Text("Pokazuj poradnik do zdjęć: ", style: getTextStyle(context, Colors.black, fontSize: 0.015),
                                  ),),),
                              ]
                          ),),

                        Padding(
                          padding: EdgeInsets.all(getMinDimension(context) * 0.1),
                          child:

                            Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: getHeight(context) * 0.1,
                                    child: Switch(
                                      value: storageController.getBool(
                                          "introduction"),
                                      onChanged: (bool value) {
                                        //setState(() async {
                                        storageController.setBool(
                                            "introduction",
                                            !storageController.getBool(
                                                "introduction"));
                                        //});
                                      },
                                      activeTrackColor: Colors.black,
                                      hoverColor: Colors.black,
                                    ),
                                  ),

                                  SizedBox(
                                      height: getHeight(context) * 0.1,
                                      child: Switch(
                                        value: storageController.getBool(
                                            "tutorial"),
                                        onChanged: (bool value) {
                                          //setState(() async {
                                          storageController.setBool(
                                              "tutorial",
                                              !storageController.getBool(
                                                  "tutorial"));
                                          //});
                                        },
                                        activeTrackColor: Colors.black,
                                        hoverColor: Colors.black,
                                      )),
                                ]),),
                      ])
                ]
            ),

            CustomNavigationBar()
          ],
        ),
      );
    });
  }
}