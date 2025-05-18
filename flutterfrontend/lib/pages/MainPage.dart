import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';

import '../api/ApiCaller.dart';

double screenWidth = 0;
double screenHeight = 0;

Future<void> setInfoToRead() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  
  await prefs.setBool('read', true);
}

Future<bool> getInfoRead() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  
  bool? result = prefs.getBool('read');

  if (result == null) {
    return false;
  }
  return true;
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

Future<PlatformFile> getLocalFile() async{
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

class MainPage extends StatelessWidget {
  @override
  MainPage({super.key});

  void showCustomModalBottomSheet(BuildContext context, String text) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: screenWidth * 0.75,
          color: Colors.transparent,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,

              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenHeight * 0.05,
                  ),
                  child: Text(
                    textAlign: TextAlign.center,
                    text,
                    style: GoogleFonts.getFont(
                      'DM Serif Text',
                      textStyle: TextStyle(
                        fontSize: screenHeight * 0.025,
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.1),
              ],
            ),
          ),
        );
      },
    );
  }

  Material customButton(BuildContext context, String text, IconData iconData) {
    return Material(
      elevation: 20,
      borderRadius: BorderRadius.circular(8),

      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8),
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 0, 0, 0),
                  Color.fromARGB(255, 61, 61, 61),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: IconButton(
              icon: Icon(
                iconData,
                size: screenHeight * 0.15,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              onPressed: () async {
                //String result = await ApiCaller.getResult();

                // ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(content: Text(result)),
                // );
              },

              style: IconButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
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

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        //title: const Text('Aplikacja do diagnozy paznokci'),
        backgroundColor:
            Colors.white, //const Color.fromARGB(255, 237, 235, 235),

        title: Text(
          'Diagnozer paznokci',
          style: GoogleFonts.getFont(
            'DM Serif Text',
            textStyle: getTextStyle(Color.fromARGB(255, 0, 0, 0)),
          ),
          textAlign: TextAlign.left,
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.question_mark_rounded),
            color: Colors.black,
            onPressed: () {
              showCustomModalBottomSheet(
                context,
                'Tutaj pojawią się informacje na temat działania aplikacji, porady korzystania z niej, informacje dotyczące zdjęć itd.',
              );
            },
          ),

          IconButton(
            icon: const Icon(Icons.share_location_sharp),
            color: Colors.black,
            onPressed: () async {
              getLocalFile();
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const InfoPage()),
              // );
            },
          ),

          IconButton(
            icon: const Icon(Icons.info_rounded),
            color: Colors.black,
            onPressed: () {
              showCustomModalBottomSheet(
                context,
                'Tutaj pojawią się informacje na temat autorów i projektu.',
              );
            },
          ),
        ],
      ),

      body: Container(
        decoration: BoxDecoration(
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
                  customButton(context, 'Wybierz zdjęcie', Icons.image_rounded),

                  SizedBox(width: screenHeight * 0.06),

                  customButton(
                    context,
                    'Prześlij zdjęcie',
                    Icons.camera_alt_rounded,
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
                width: screenWidth * 0.7,
                height: screenHeight * 0.4,

                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 0, 0, 0),
                        Color.fromARGB(255, 61, 61, 61),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),

                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                      vertical: screenHeight * 0.05,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Kliknij ikonę znaku zapytania, aby uzyskać więcej informacji o aplikacji.\n\nKliknij ikonę info, aby uzyskać więcej informacji o autorach i projekcie.',
                          textAlign: TextAlign.center,
                          style: getTextStyle(
                            Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
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
          style: getTextStyle(Color.fromARGB(255, 0, 0, 0), fontSize: 0.03),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: RichText(
          text: TextSpan(
            style: getTextStyle(Color.fromARGB(255, 0, 0, 0)),
            children: [
              TextSpan(
                text: 'Nasza aplikacja',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: ' służy do wczesnego diagnozowania chorób paznokci. Udziela jedynie porad, które mogą być podstawą wizyty u dermatologa.'),
              
              TextSpan(
                text: '\n\nZdjęcia, które zrobisz',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: ', nie będą przechowywane w żadnej bazie danych - kod jest dostępny publicznie. Pamiętaj, żeby były dobrze oświetlone i zrobione od góry. Obsługiwane formaty to PNG, JPEG, TIFF i BMP, a maksymalna wielkość zdjęcia to 5 MB.'),
            
              TextSpan(
                text: '\n\nWięcej informacji',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: ' uzyskasz na naszym Githubie: github.com'),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}