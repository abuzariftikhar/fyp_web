import 'package:flutter/material.dart';

class HomeBloc extends ChangeNotifier {
  bool videoStream = false;
  String raspberryPiIP = '192.168.1.1';
  String raspberryPiPort = '8080';
  bool isRecording = false;
  int index = 0;
  update() {
    notifyListeners();
  }
}
