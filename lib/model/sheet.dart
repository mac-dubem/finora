// import 'package:flutter/material.dart';



// late MyAppTheme myAppTheme;

// /// Theme Manager (handles light/dark switching)
// class MyAppTheme with ChangeNotifier {
//   bool isWhite = true; // true = Light mode, false = Dark mode

//   set setIsWhite(bool val) {
    
//     isWhite = val;
//     notifyListeners();
//   }

//   /// Switch between light and dark
//   ///
//   // void toggle() {
//   //   isWhite = !isWhite;
//   //   notifyListeners(); // notify widgets to rebuild
//   // }

//   /// Colors that adapt to theme
//   Color get kIconColor =>
//       isWhite ? WhiteTheme.kIconColor : DarkTheme.kIconColor;

//   Color get kBgColor => isWhite ? WhiteTheme.kBgColor : DarkTheme.kBgColor;

//   Color get kAppTextColor =>
//       isWhite ? WhiteTheme.kAppTextColor : DarkTheme.kAppTextColor;

//   Color get kTabBarColor =>
//       isWhite ? WhiteTheme.kTabBarColor : DarkTheme.kTabBarColor;

//   Color get kWhiteTextColor =>
//       isWhite ? WhiteTheme.kWhiteTextColor : DarkTheme.kWhiteTextColor;

//   Color get kContainerColor =>
//       isWhite ? WhiteTheme.kContainerColor : DarkTheme.kContainerColor;
// }

// /// Light theme colors
// class WhiteTheme {
//   static const Color kIconColor = Color(0xFFD9D9D9);
//   static const Color kBgColor = Color(0xFFF4F4F4);
//   static const Color kAppTextColor = Color(0xFF1C1C1C);
//   static const Color kTabBarColor = Color(0xFF929292);
//   static const Color kWhiteTextColor = Colors.white;
//   static const Color kContainerColor = Colors.white;
// }

// /// Dark theme colors
// class DarkTheme {
//   static const Color kIconColor = Color(0xFFD9D9D9);
//   static const Color kBgColor = Color(0xFF121212);
//   static const Color kAppTextColor = Colors.white;
//   static const Color kTabBarColor = Color(0xFF929292);
//   static const Color kWhiteTextColor = Colors.white;
//   static const Color kContainerColor = Color(0xFF000000);
// }
