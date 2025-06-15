import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/CameraPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';

import '../api/ApiCaller.dart';

double screenWidth = 0;
double screenHeight = 0;

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

TextStyle getTextStyle(Color color, {double fontSize = 0.025}) {
  return GoogleFonts.getFont(
    'DM Serif Text',
    textStyle: TextStyle(
      fontSize: screenHeight * fontSize,
      color: color,
      fontWeight: FontWeight.normal,
    ),
  );
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

Material customButton(
  BuildContext context,
  String text,
  IconData iconData, {
  onPressedEvent = null,
}) {
  return Material(
    elevation: 20,
    borderRadius: BorderRadius.circular(10),

    child: Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
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
          ),
          child: IconButton(
            icon: Icon(
              iconData,
              size: screenHeight * 0.15,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            onPressed: onPressedEvent,

            style: IconButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),

              fixedSize: Size(screenWidth * 0.4, screenHeight * 0.25),
            ),
          ),
        ),

        //Text(text, style: TextStyle(fontWeight: FontWeight.normal)),
      ],
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

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageContent extends StatelessWidget {
  const MainPageContent({super.key});

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
            textStyle: getTextStyle(Color.fromARGB(255, 0, 0, 0)),
          ),
          textAlign: TextAlign.left,
        ),

        actions: [
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
                  pageBuilder:
                      (context, animation, secondaryAnimation) =>
                          const AuthorsPage(),
                  transitionsBuilder: getSlideTransition(),
                ),
              );
            },
          ),
        ],

        toolbarHeight: screenHeight * 0.09,
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
            SizedBox(height: screenHeight * 0.03),

            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customButton(
                    context,
                    'Wybierz zdjęcie',
                    Icons.image_rounded,
                    onPressedEvent: () async {
                      getLocalFile();
                    },
                  ),

                  SizedBox(width: screenHeight * 0.06),

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
                  ),
                ],
              ),
            ),

            SizedBox(height: screenHeight * 0.1),

            Card(
              elevation: 20,
              color: const Color.fromARGB(255, 237, 235, 235),
              //margin: EdgeInsets.all(16),
              child: SizedBox(
                //width: screenWidth * 0.7,
                //height: screenHeight * 0.4,

                child: Container(
                  decoration: BoxDecoration(
          //           image: DecorationImage(
          //   image: AssetImage("../resources/nailphoto.jpg"),
          //   fit: BoxFit.cover,
          // ),
                    borderRadius: BorderRadius.circular(8),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 0, 0, 0),
                        Color.fromARGB(255, 61, 61, 61),
                      ],
                      begin: Alignment.topCenter,
                      //end: Alignment.bottomCenter,
                    ),
                  ),

                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                      vertical: screenHeight * 0.05,
                    ),
                      //mainAxisSize: MainAxisSize.min,
                      child: Text(
                          //'Kliknij ikonę znaku zapytania, aby uzyskać więcej informacji o aplikacji.\n\nKliknij ikonę info, aby uzyskać więcej informacji o autorach i projekcie.',
                          "todo: instrukcje tutaj",
                          //textAlign: TextAlign.center,
                          style: getTextStyle(
                            Color.fromARGB(255, 255, 255, 255),
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
    );
  }
}

class MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return MainPageContent();

    //setInfoRead("true"); // TODO: REMOVE THIS (THIS IS FOR TESTING ONLY)

    // var builder = FutureBuilder<String>(
    //   future: getInfoReadString(),
    //   builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Center(
    //         child: Text(
    //           'Ładowanie...',
    //           style: getTextStyle(Color.fromARGB(255, 0, 0, 0)),
    //         ),
    //       );
    //     } else {
    //       if (snapshot.hasError) {
    //         return Center(
    //           child: Text(
    //             'Błąd: ${snapshot.error}',
    //             style: getTextStyle(Color.fromARGB(255, 0, 0, 0)),
    //           ),
    //         );
    //       }
    //       if (snapshot.data == "false") {
    //         // TODO: INVERSE THIS (THIS IS FOR TESTING ONLY)
    //         //setInfoRead("true");
    //
    //         WidgetsBinding.instance.addPostFrameCallback((_) {
    //           Navigator.of(context).push(
    //             PageRouteBuilder(
    //               pageBuilder:
    //                   (context, animation, secondaryAnimation) =>
    //                       const InfoPage(),
    //               transitionsBuilder: getSlideTransition(),
    //             ),
    //           );
    //         });
    //       }
    //       return MainPageContent();
    //     }
    //   },
    // );

    //return builder;
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
          style: getTextStyle(Color.fromARGB(255, 0, 0, 0), fontSize: 0.03),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: screenHeight * 0.1),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: RichText(
              text: TextSpan(
                style: getTextStyle(Color.fromARGB(255, 0, 0, 0)),
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
          style: getTextStyle(Color.fromARGB(255, 0, 0, 0), fontSize: 0.03),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: screenHeight * 0.1),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: RichText(
              text: TextSpan(
                style: getTextStyle(Color.fromARGB(255, 0, 0, 0)),
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
