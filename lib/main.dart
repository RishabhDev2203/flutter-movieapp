import 'package:flutter/material.dart';
import 'package:flutter_firebase_ott/splash.dart';
import 'package:flutter_firebase_ott/util/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: Constants.fontFamily,
      ),
      home: const Splash(),
    );
  }
}

