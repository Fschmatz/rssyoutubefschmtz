import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//CLARO
    ThemeData light = ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFFEAEAF2), //mais esc 0xFFEAEAEE
    accentColor: Colors.green,
    scaffoldBackgroundColor: Color(0xFFF9F9FF),

    cardTheme: CardTheme(
      color: Color(0xFFF1F1F4),
    ),

    dialogTheme: DialogTheme(
      backgroundColor: Color(0xFFF9F9FF),
    ),

    );

//ESCURO
    ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color(0xFF252528),
    accentColor: Colors.green,
    scaffoldBackgroundColor: Color(0xFF1C1C1F),

    cardTheme: CardTheme(
      color: Color(0xFF242529),
    ),

    dialogTheme: DialogTheme(
      backgroundColor: Color(0xFF202124),
    ),

    );

class ThemeNotifier extends ChangeNotifier {
  final String key = 'valorTema';
  SharedPreferences prefs;
  bool _darkTheme;

  bool get darkTheme => _darkTheme;

  ThemeNotifier() {
    _darkTheme = true;
    _loadFromPrefs();
  }

  toggleTheme() {
    _darkTheme = !_darkTheme;
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
  }

  _loadFromPrefs() async {
    await _initPrefs();
    _darkTheme = prefs.getBool(key) ?? true;
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    prefs.setBool(key, _darkTheme);
  }
}
