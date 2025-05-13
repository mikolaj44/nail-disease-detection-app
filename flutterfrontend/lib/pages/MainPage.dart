import 'package:flutter/material.dart';
import '../api/ApiCaller.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  void showCustomModalBottomSheet(BuildContext context, String text) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: 400,
          color: Colors.transparent,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,

              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    textAlign: TextAlign.center,
                    text,
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Aplikacja do diagnozy paznokci'),
        backgroundColor: const Color.fromARGB(255, 237, 235, 235),

        actions: [
          IconButton(
            icon: const Icon(Icons.question_mark),
            onPressed: () {
              showCustomModalBottomSheet(context, 'Tutaj pojawią się informacje na temat działania aplikacji, porady korzystania z niej, informacje dotyczące zdjęć itd.');
            },
          ),

          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              showCustomModalBottomSheet(context, 'Tutaj pojawią się informacje na temat autorów i projektu.');
            },
          ),
        ],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20),

          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        //border: Border.all(color: Colors.black, width: 2),
                        color: const Color(0XFFBAC7BD),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.image_rounded,
                          size: 100,
                          color: Color.fromARGB(255, 192, 207, 200),
                        ),
                        iconSize: 100,
                        //padding: EdgeInsets.all(0),
                        onPressed: () async {
                          //String result = await ApiCaller.getResult();

                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(content: Text(result)),
                          // );
                        },

                        //child: const Text('Take a photo'),
                        style: IconButton.styleFrom(
                          backgroundColor:
                              Colors
                                  .white54, //const Color.fromARGB(255, 255, 250, 206),
                          foregroundColor: Colors.white54,

                          //textStyle: const TextStyle(fontSize: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              8,
                            ), // Rounded corners
                          ),

                          fixedSize: Size(200, 250),
                        ),
                      ),
                    ),

                    Text(
                      'Zrób zdjęcie',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                SizedBox(width: 20),

                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        //border: Border.all(color: Colors.black, width: 2),
                        color: const Color(0XFFBAC7BD),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.camera_alt_rounded,
                          size: 100,
                          color: Color.fromARGB(255, 192, 207, 200),
                        ),
                        iconSize: 100,
                        //padding: EdgeInsets.all(0),
                        onPressed: () async {
                          //String result = await ApiCaller.getResult();

                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(content: Text(result)),
                          // );
                        },

                        //child: const Text('Take a photo'),
                        style: IconButton.styleFrom(
                          backgroundColor:
                              Colors
                                  .white54, //const Color.fromARGB(255, 255, 250, 206),
                          foregroundColor: Colors.white54,

                          //textStyle: const TextStyle(fontSize: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              8,
                            ), // Rounded corners
                          ),

                          fixedSize: Size(200, 250),
                        ),
                      ),
                    ),

                    Text(
                      'Prześlij zdjęcie',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF7F7F7),
    );
  }
}
