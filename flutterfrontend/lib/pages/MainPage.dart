import 'package:flutter/material.dart';
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
                  child: Text(textAlign: TextAlign.center, text),
                ),
                SizedBox(height: screenHeight * 0.1),
              ],
            ),
          ),
        );
      },
    );
  }

  Column customButton(BuildContext context, String text, IconData iconData) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0XFFBAC7BD),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            icon: Icon(
              iconData,
              size: screenHeight * 0.18,
              color: Color.fromARGB(255, 192, 207, 200),
            ),
            onPressed: () async {
              //String result = await ApiCaller.getResult();

              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(content: Text(result)),
              // );
            },

            style: IconButton.styleFrom(
              backgroundColor: Colors.white54,
              foregroundColor: Colors.white54,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),

              fixedSize: Size(screenWidth * 0.4, screenHeight * 0.25),
            ),
          ),
        ),

        Text(text, style: TextStyle(fontWeight: FontWeight.normal)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Aplikacja do diagnozy paznokci'),
        backgroundColor: const Color.fromARGB(255, 237, 235, 235),

        actions: [
          IconButton(
            icon: const Icon(Icons.question_mark),
            onPressed: () {
              showCustomModalBottomSheet(
                context,
                'Tutaj pojawią się informacje na temat działania aplikacji, porady korzystania z niej, informacje dotyczące zdjęć itd.',
              );
            },
          ),

          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              showCustomModalBottomSheet(
                context,
                'Tutaj pojawią się informacje na temat autorów i projektu.',
              );
            },
          ),
        ],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,

        children: <Widget>[
          SizedBox(height: screenHeight * 0.07),

          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customButton(context, 'Wybierz zdjęcie', Icons.image_rounded),

                SizedBox(width: screenHeight * 0.05),

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
            elevation: 4,
            color: const Color.fromARGB(255, 237, 235, 235),
            //margin: EdgeInsets.all(16),
            child: SizedBox(
              width: screenWidth * 0.7,
              height: screenHeight * 0.4,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.05,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Kliknij ikonę znaku zapytania, aby uzyskać więcej informacji o aplikacji.\n\nKliknij ikonę info, aby uzyskać więcej informacji o autorach i projekcie.', textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
