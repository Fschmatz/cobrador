import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

  //CLARO
  ThemeData light = ThemeData(

    brightness: Brightness.light,
    primaryColor: Color(0xFF55565A),//0xFF37474f
    accentColor: Color(0xFF13AC8E), //Color(0xFF258545) vrd
    scaffoldBackgroundColor: Color(0xFFFCFCFD),

    cardTheme: CardTheme(
      color: Color(0xFFF7F7FA), //0xFFFAFAFC
    ),

    dialogTheme: DialogTheme(
      backgroundColor: Color(0xFFFAFAFF),
    ),

    cursorColor:  Color(0xFF13AC8E),
    inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: Colors.black),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF13AC8E))
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF282828)))
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xFFF4F4F7),
      selectedLabelStyle: TextStyle(color: Colors.black),
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey[400],
      showUnselectedLabels: true,
    ),

      buttonColor: Color(0xFF13AC8E),
    bottomSheetTheme: BottomSheetThemeData(modalBackgroundColor: Color(0xFFFDFDFF))

  );



  //ESCURO
  ThemeData dark = ThemeData(

    brightness: Brightness.dark,
    primaryColor: Color(0xFF35363B),// 3a antes
    accentColor: Color(0xFF0b8a6e),
    scaffoldBackgroundColor: Color(0xFF202123),//0xFF202124

    cardTheme: CardTheme(
        color: Color(0xFF27272A)//0xFF2A2A2F
    ),

    dialogTheme: DialogTheme(
        backgroundColor: Color(0xFF202020)
    ),

    cursorColor: Color(0xFF0b8a6e),
    inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: Colors.white),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF0b8a6e))),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF282828)))
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF202123),
      selectedLabelStyle: TextStyle(color: Colors.white),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey[800],
      showUnselectedLabels: true,
    ),

    buttonColor: Color(0xFF0b8a6e),
    bottomSheetTheme: BottomSheetThemeData(modalBackgroundColor: Color(0xFF27272A))
  );


class ThemeNotifier extends ChangeNotifier{

  final String key = 'valorTema';
  SharedPreferences prefs;
  bool _darkTheme;

  bool get darkTheme => _darkTheme;

  ThemeNotifier(){
    _darkTheme = true;
    _loadFromPrefs();
  }

  toggleTheme(){
    _darkTheme = !_darkTheme;
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async{
    if(prefs == null){
      prefs = await SharedPreferences.getInstance();
    }
  }

  _loadFromPrefs() async{
    await _initPrefs();
    _darkTheme = prefs.getBool(key) ?? true;
    notifyListeners();
  }

  _saveToPrefs() async{
    await _initPrefs();
    prefs.setBool(key, _darkTheme);
  }
}


