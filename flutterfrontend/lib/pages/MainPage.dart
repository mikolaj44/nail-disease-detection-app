import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../api/ApiCaller.dart';

class MainPage extends StatelessWidget {
  double screenWidth = 0;
  double screenHeight = 0;

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
                  child: Text(textAlign: TextAlign.center, text, style: GoogleFonts.getFont(
                    'DM Serif Text',
                    textStyle: TextStyle(
                      fontSize: screenHeight * 0.025,
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.normal,
                    ),
                  )),
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
            textStyle: TextStyle(
              fontSize: screenHeight * 0.031,
              color: const Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold,
            ),
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
                          style: GoogleFonts.getFont(
                            'DM Serif Text',
                            textStyle: TextStyle(
                              fontSize: screenHeight * 0.025,
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.normal,
                            ),
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
