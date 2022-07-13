import 'package:flutter/material.dart';

class UserLogger extends ChangeNotifier {
  String _username = "John Doe";

  String get getUsername => _username;

  void setUsername(String username) {
    if (username.isNotEmpty) {
      _username = username;
    } else {
      _username = "John Doe";
    }
    notifyListeners();
  }
}
