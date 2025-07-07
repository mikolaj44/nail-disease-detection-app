import 'package:auto_size_text/auto_size_text.dart';
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
    languages.map<MenuEntry>(
      (String name) => MenuEntry(
          value: name,
          label: name,
        ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Consumer<StorageController>(
      builder: (context, analysis, child) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("resources/waves.png"),
                      fit: BoxFit.cover,
                    ),
                  ),

                  child: SingleChildScrollView(
                    //child: ConstrainedBox(
        //           constraints: BoxConstraints(
        // maxHeight: getHeight(context),
        // minHeight: getHeight(context)
        // ),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        getTopBar(context, "Ustawienia", alignLeft: false),
                        Column(
                          children: [
                            //SizedBox(height: getHeight(context) * 0.1),
                            Padding(
                              padding: EdgeInsets.all(
                                getMinDimension(context) * 0.05,
                              ),
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
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              height: getHeight(context) * 0.1,
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Język: ",
                                                  style: getTextStyle(
                                                    context,
                                                    Colors.black,
                                                    fontSize: 0.045,
                                                  ),
                                                ),
                                              ),
                                            ),

                                            Container(
                                              decoration: BoxDecoration(
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Color.fromARGB(
                                                      255,
                                                      155,
                                                      176,
                                                      208,
                                                    ),
                                                    Color.fromARGB(
                                                      255,
                                                      193,
                                                      173,
                                                      204,
                                                    ),
                                                    Color.fromARGB(
                                                      255,
                                                      222,
                                                      177,
                                                      181,
                                                    ),
                                                    Color.fromARGB(
                                                      255,
                                                      220,
                                                      194,
                                                      168,
                                                    ),
                                                  ],
                                                  //stops: [0.2, 0.3, 0.4, 0.6],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ),
                                              ),
                                              child: DropdownMenu<String>(
                                                initialSelection:
                                                    languages.first,
                                                onSelected: (String? value) {
                                                  // TODO: not finding the locale for some reason, also add translations
                                                  //context.setLocale(locales[languages.indexOf(value!)]);
                                                },
                                                dropdownMenuEntries:
                                                    menuEntries,
                                                textStyle: getTextStyle(
                                                  context,
                                                  Colors.black,
                                                ),
                                                inputDecorationTheme:
                                                    InputDecorationTheme(
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                  color:
                                                                      Colors
                                                                          .black,
                                                                ),
                                                          ),
                                                    ),
                                                enableSearch: false,
                                                enableFilter: false,
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

                            //SizedBox(height: getHeight(context) * 0.05),
                            Padding(
                              padding: EdgeInsets.all(
                                getMinDimension(context) * 0.05,
                              ),
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

                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            height: getHeight(context) * 0.1,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "Pokazuj wprowadzenie: ",
                                                style: getTextStyle(
                                                  context,
                                                  Colors.black,
                                                  fontSize: 0.045,
                                                ),
                                              ),
                                            ),
                                          ),

                                          Switch(
                                            value: storageController.getBool(
                                              "introduction",
                                            ),
                                            onChanged: (bool value) {
                                              //setState(() async {
                                              storageController.setBool(
                                                "introduction",
                                                !storageController.getBool(
                                                  "introduction",
                                                ),
                                              );
                                              //});
                                            },

                                            activeTrackColor: Color.fromARGB(
                                              255,
                                              155,
                                              176,
                                              208,
                                            ),
                                            //focusColor: Color.fromARGB(20, 0, 0, 0),
                                            trackOutlineColor:
                                                MaterialStateProperty.resolveWith(
                                                  (
                                                    final Set<MaterialState>
                                                    states,
                                                  ) {
                                                    if (states.contains(
                                                      MaterialState.selected,
                                                    )) {
                                                      return null;
                                                    }

                                                    return Colors.black;
                                                  },
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.all(
                                getMinDimension(context) * 0.05,
                              ),
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

                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            height: getHeight(context) * 0.1,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "Pokazuj poradnik do zdjęć: ",
                                                style: getTextStyle(
                                                  context,
                                                  Colors.black,
                                                  fontSize: 0.045,
                                                ),
                                              ),
                                            ),
                                          ),

                                          Switch(
                                            value: storageController.getBool(
                                              "tutorial",
                                            ),
                                            onChanged: (bool value) {
                                              //setState(() async {
                                              storageController.setBool(
                                                "tutorial",
                                                !storageController.getBool(
                                                  "tutorial",
                                                ),
                                              );
                                              //});
                                            },
                                            activeTrackColor: Color.fromARGB(
                                              255,
                                              155,
                                              176,
                                              208,
                                            ),
                                            // trackColor: Color.fromARGB(255, 155, 176, 208),
                                            trackOutlineColor:
                                                MaterialStateProperty.resolveWith(
                                                  (
                                                    final Set<MaterialState>
                                                    states,
                                                  ) {
                                                    if (states.contains(
                                                      MaterialState.selected,
                                                    )) {
                                                      return null;
                                                    }

                                                    return Colors.black;
                                                  },
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: getHeight(context) * 0.15, // TODO: probably make a height property of the custom navigation bar
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(bottom: 0, child: CustomNavigationBar()),
              ],
            ),
          ),
        );
      },
    );
  }
}
