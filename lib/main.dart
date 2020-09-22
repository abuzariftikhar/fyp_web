import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp_web/homePage.dart';
import 'package:fyp_web/homebloc.dart';
import 'package:provider/provider.dart';

main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Surveillance App',
        home: AuthenticationPage(),
        theme: ThemeData(
          primarySwatch: Colors.grey,
          cursorColor: Colors.black,
          errorColor: Colors.pink
        ),
      ),
    );
  }
}
