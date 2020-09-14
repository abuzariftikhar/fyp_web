import 'package:flutter/material.dart';
import 'package:fyp_web/HomePage.dart';

main() {
  runApp(App());
}


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Khawar bhai FYP walay baba',
      theme: ThemeData(
        fontFamily: 'kumho',
      ),
      home: HomePage(),
    );
  }
}