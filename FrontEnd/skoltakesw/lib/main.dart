import 'package:flutter/material.dart';
import 'package:skoltakesw/pages/Home.dart';
import 'package:skoltakesw/pages/SignUpPage.dart';
import 'package:skoltakesw/pages/LoginPage.dart';
import 'package:skoltakesw/pages/LoadingPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/loading': (context) => LoadingPage(),
      },
      // setting the routes

      initialRoute: '/loading',
      // setting the initial route
    );
  }
}
