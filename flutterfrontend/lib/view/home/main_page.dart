import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/camera/camera_page.dart';
import 'package:flutter_application_1/utils/other/dimension_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';

import '../../utils/other/style/style_methods.dart';

Future<void> setInfoRead(String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setString('read', value);
}

Future<String> getInfoReadString() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  String? result = prefs.getString("read");

  if (result == null) {
    return "false";
  }
  return "true";
}

Future<PlatformFile> getLocalFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['png', 'jpg', 'tiff', 'bmp'], // call api here
  );

  if (result != null) {
    return Future.value(result.files.first);
  } else {
    return Future.value(null); // probably throw an exception
  }
}

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

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int activeCarouselPageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        //title: const Text('Aplikacja do diagnozy paznokci'),
        backgroundColor:
        Colors.white, //const Color.fromARGB(255, 237, 235, 235),

        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 220, 194, 168),
                //Color.fromARGB(255,222,177,181),
                //Color.fromARGB(255,193,173,204),
                Color.fromARGB(255, 155, 176, 208),
              ],
              //stops: [0.2, 0.3, 0.4, 0.6],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),

        //shape: Border(bottom: BorderSide(color: const Color.fromARGB(255, 255, 205, 205), width: 1)),
        title: Text(
          'Diagnozer paznokci',
          style: GoogleFonts.getFont(
            'DM Serif Text',
            fontWeight: FontWeight.bold,
            textStyle: getTextStyle(context, Color.fromARGB(255, 0, 0, 0)),
          ),
          textAlign: TextAlign.left,
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.language_rounded),
            color: Colors.black,
            onPressed: () {
              // Navigator.of(context).push(
              //   PageRouteBuilder(
              //     pageBuilder: (context, animation, secondaryAnimation) => const AuthorsPage(),
              //     transitionsBuilder: getSlideTransition(),
              //   ),
              // );
            },
          ),

          IconButton(
            icon: const Icon(Icons.question_mark_rounded),
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder:
                      (context, animation, secondaryAnimation) =>
                  const InfoPage(),
                  transitionsBuilder: getSlideTransition(),
                ),
              );
            },
          ),

          IconButton(
            icon: const Icon(Icons.people),
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const AuthorsPage(),
                  transitionsBuilder: getSlideTransition(),
                ),
              );
            },
          ),
        ],

        toolbarHeight: getHeight(context) * 0.09,
      ),

      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("resources/waves.png"),
              fit: BoxFit.cover,
            ),
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 225, 224, 224),
              ],

              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,

            children: <Widget>[
              SizedBox(height: getHeight(context) * 0.03),

              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SizedBox(height: getHeight(context) * 0.025),

                    Align(
                      alignment: Alignment.center,
                    child:
                    Row(
                      children: [
                        SizedBox(width: getWidth(context) * 0.07),

                        customButton(
                          context,
                          'Wybierz zdjęcie',
                          Icons.image_rounded,
                          onPressedEvent: () async {
                            getLocalFile();
                          },
                          size: 0.3,
                          iconSizeMult: 0.1,
                        ),

                        SizedBox(width: getWidth(context) * 0.05),

                        customButton(
                          context,
                          'Prześlij zdjęcie',
                          Icons.camera_alt_rounded,
                          onPressedEvent: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CameraPage()),
                            );
                          },
                          size: 0.5,
                          iconSizeMult: 0.15,
                        ),
                      ],
                    ),
                    ),


                    SizedBox(height: getHeight(context) * 0.025),

                  ],
                ),
              ),

              SizedBox(height: getHeight(context) * 0.1),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        height: getHeight(context) * 0.15,
      ),
    );
  }
}

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ważne informacje',
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
                    text: 'Nasza aplikacja',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        ' służy do wczesnego diagnozowania chorób paznokci. Udziela jedynie porad, które mogą być podstawą wizyty u dermatologa.',
                  ),

                  TextSpan(
                    text: '\n\nZdjęcia, które zrobisz',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        ', nie będą przechowywane w żadnej bazie danych - kod jest dostępny publicznie. Pamiętaj, żeby były dobrze oświetlone i zrobione od góry. Obsługiwane formaty to PNG, JPEG, TIFF i BMP, a maksymalna wielkość zdjęcia to 5 MB.',
                  ),

                  TextSpan(
                    text: '\n\nWięcej informacji',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        ' uzyskasz na naszym Githubie: xyz.github.com - projekt realizowany w ramach koła naukowego "Praktyka".',
                  ),
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
