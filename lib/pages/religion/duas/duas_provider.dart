import 'package:flutter/material.dart';

class DuasProvider extends ChangeNotifier {
  List<String> _duas = [];
  List<String> get duas => _duas;
  void addDuas(String quote) {
    final isExist = _duas.contains(quote);
    if (isExist) {
      _duas.remove(quote);
    } else {
      _duas.add(quote);
    }
    notifyListeners();
  }

  bool isExist(String quote) {
    final isExist = _duas.contains(quote);
    return isExist;
  }

  void clearFavoite() {
    _duas = [];
    notifyListeners();
  }
}
