import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyThemeNotifier with ChangeNotifier {
  bool _isDark;
  SharedPreferences preferences;
  bool get isDark => _isDark;
  MyThemeNotifier() {
    _isDark = true;
    loadFromPref();
  }
  void switchTheme() {
    _isDark = !_isDark;
    savePref();
    notifyListeners();
  }

  initPref() async {
    if (preferences == null)
      preferences = await SharedPreferences.getInstance();
  }

  loadFromPref() async {
    await initPref();
    _isDark = preferences.getBool("theme") ?? false;
    notifyListeners();
  }

  savePref() async {
    await initPref();
    preferences.setBool("theme", _isDark);
  }
}
