import 'package:flutter/material.dart';

class HomeBloc extends ChangeNotifier {
  bool videoStream = false;
  String raspberryPiIP = '192.168.1.1';
  String controlPort = '8080';
  String streamPort = '9000';
  int index = 0;
  update() {
    notifyListeners();
  }
}
