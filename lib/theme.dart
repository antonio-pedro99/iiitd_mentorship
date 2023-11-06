import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iiitd_mentorship/constants.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      fontFamily: "Muli",
      primaryColor: kPrimaryColor,
      useMaterial3: true,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
      ),
      appBarTheme: AppBarTheme.of(context).copyWith(
        backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.white,
        ),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: kTextColor),
        bodyMedium: TextStyle(color: kTextColor),
        bodySmall: TextStyle(color: kTextColor),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
