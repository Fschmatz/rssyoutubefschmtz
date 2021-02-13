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
    primaryColor: Color(0xFF252528),// cza escuro anterior 0xFF18191C
    accentColor: Colors.green,  //LRJ ESC Color(0xFFCB6539) e68040
    scaffoldBackgroundColor: Color(0xFF202023),

    cardTheme: CardTheme(
      color: Color(0xFF202023),//0xFF252629
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
