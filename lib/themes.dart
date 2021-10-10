import 'package:flutter/material.dart';

CustomTheme currentTheme = CustomTheme();

class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme = false;
  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static ThemeData get lightTheme {
    return ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFFDEDEDE)
      ),
      primaryColor: Color(0xFFDEDEDE),
      shadowColor: Colors.grey.shade900, //borders,
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: Colors.grey.shade800,
      cardColor: Color(0xFF5D5D5D), // new button color
      canvasColor: Colors.grey.shade400, //Button onPrimary/click effect
      textTheme: TextTheme(
        headline1: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold, decoration: TextDecoration.underline,), //forgot password
        headline2: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400), //create new Account
        bodyText1: TextStyle(color: Colors.white, fontSize: 27),//login button
        bodyText2: TextStyle(color: Colors.black, fontSize: 50),//login header
        headline6: TextStyle(color: Colors.black, fontSize: 27),//title scaffold
        headline3: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold,), //Text above Inputfields
        headline4: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold,), //DateText
        headline5: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold,), //Uhrzeit
        caption: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold,), //Bilder
        subtitle1: TextStyle(color: Colors.grey.shade700, fontSize: 18, fontWeight: FontWeight.bold,), //Language Greyed out
        subtitle2: TextStyle(color: Colors.white, fontSize: 27), //logout
      ),
      iconTheme: IconThemeData(//theme icon switch color
          color: Colors.black
      ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.grey.shade900),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF2e2e2e)
      ),
      primaryColor: Color(0xFF2e2e2e),
      shadowColor: Colors.white,//borders new accent color
      backgroundColor: Color(0xFF212121),
      scaffoldBackgroundColor: Colors.grey.shade800,
      cardColor: Color(0xFF5D5D5D), // new button color
      canvasColor: Colors.grey.shade400, //Button onPrimary/click effect
      textTheme: TextTheme(
        headline1: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold, decoration: TextDecoration.underline,), //forgot password
        headline2: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400), //create new Account
        bodyText1: TextStyle(color: Colors.white, fontSize: 27),//login button
        bodyText2: TextStyle(color: Colors.white, fontSize: 50),//login header
        headline6: TextStyle(color: Colors.white, fontSize: 27),//title scaffold
        headline3: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold,), //Text above Inputfields
        headline4: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold,), //DateText
        headline5: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold,), //Uhrzeit
        caption: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold,), //Bilder
        subtitle1: TextStyle(color: Colors.grey.shade400, fontSize: 18, fontWeight: FontWeight.bold,), //Language Greyed out
        subtitle2: TextStyle(color: Colors.black, fontSize: 27), //logout button
      ),
      iconTheme: IconThemeData(//theme icon switch color
          color: Colors.white
      ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
    );
  }
}