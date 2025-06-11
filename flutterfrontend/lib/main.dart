import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/CameraPage.dart';
import 'pages/MainPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nail App',
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}