import 'package:flutter/material.dart';

class UserSelector extends ChangeNotifier {
  String _fullName = "Selected User Name";

  String get getFullName => _fullName;

  void setFullName(String fullName) {
    _fullName = fullName;
    notifyListeners();
  }
}
