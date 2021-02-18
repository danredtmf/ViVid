import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStateNotifier extends ChangeNotifier {
  final String key = 'theme';
  SharedPreferences _prefs;

  bool isDarkModeOn;

  void updateTheme(bool isDarkModeOn) {
    this.isDarkModeOn = isDarkModeOn;
    notifyListeners();
  }

  AppStateNotifier() {
    isDarkModeOn = false;
    _loadFromPrefs();
  }

  toogleTheme() {
    isDarkModeOn = !isDarkModeOn;
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    if(_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  _loadFromPrefs() async {
    await _initPrefs();
    isDarkModeOn = _prefs.getBool(key) ?? true;
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    _prefs.setBool(key, isDarkModeOn);
  }
}