import 'package:flutter/material.dart';

class BoolNotifier extends ChangeNotifier {
  bool _value = false;

  bool get value => _value;

  void toggleValue() {
    _value = !_value;
    notifyListeners();
  }

  void setValue(bool newValue) {
    _value = newValue;
    notifyListeners();
  }
}
