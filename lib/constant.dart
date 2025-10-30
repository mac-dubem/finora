import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';

// const TextStyle sectionTitleStyle = TextStyle(
//   fontWeight: FontWeight.bold,
//   color:

// );
const TextStyle outwardTextStyle = TextStyle(
  color: Colors.red,
  fontWeight: FontWeight.bold,
);
const TextStyle inwardTextStyle = TextStyle(
  color: Colors.green,
  fontWeight: FontWeight.bold,
);

// const Color kBackgroundColor = Colors.white;
const Color kContainerColor = Color(0xFFE0E0E0);
// const Color kHighlightColor = ;
const Color kFocusButtonColor = Color(0xFF0D47A1);
const Color kContainerTextColor = Color(0xFF000000);
// const Decoration

const TextStyle kTItleTextStyle = TextStyle(
  fontWeight: FontWeight.w700,
  color: Color(0xFF757575),
);
const double kTitleTopPadding = 15.0;



late MyAppTheme myAppTheme;

class MyAppTheme with ChangeNotifier {
  bool isWhite = true;

  set setIsWhite(bool val) {
    isWhite = val;

    notifyListeners();
  }

  /// Colors that adapt to theme
  Color get kBackgroundColor =>
      isWhite ? WhiteTheme.kBackgroundColor : DarkTheme.kBackgroundColor;
  Color get kContainerColor =>
      isWhite ? WhiteTheme.kContainerColor : DarkTheme.kContainerColor;
  Color get kSectionTitleColor =>
      isWhite ? WhiteTheme.kSectionTitleColor : DarkTheme.kSectionTitleColor;
  Color get kHighlightColor =>
      isWhite ? WhiteTheme.kHighlightColor : DarkTheme.kHighlightColor;

  Color get kContainerTextColor =>
      isWhite ? WhiteTheme.kContainerTextColor : DarkTheme.kContainerTextColor;
  Color get kButtonColor =>
      isWhite ? WhiteTheme.kButtonColor : DarkTheme.kButtonColor;
}

class WhiteTheme {
  static const Color kBackgroundColor = Colors.white;
  static const Color kContainerColor = Color(0xFFE0E0E0);
  static const Color kSectionTitleColor = Color(0xFF616161);
  static const Color kHighlightColor = Color(0xFF0D47A1);
  static const Color kButtonColor = Color(0xFF0D47A1);
  static const Color kContainerTextColor = Color(0xFF000000);
  // static const Color kDropDownTexColo
}

class DarkTheme {
  static const Color kBackgroundColor = Color(0xFF0F0F0F);
  static const Color kContainerColor = Color(0xFF1A1A1A);
  static const Color kSectionTitleColor = Color(0xFFFFFFFF);
  static const Color kHighlightColor = Colors.white;
  static const Color kButtonColor = Color(0xFF0D47A1);
  static const Color kContainerTextColor = Colors.white;
}
