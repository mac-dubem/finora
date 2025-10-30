import 'package:finora/constant.dart';
import 'package:finora/screens/finora_screen.dart';
import 'package:finora/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  myAppTheme = MyAppTheme();

  runApp(FinoraApp());
}

class FinoraApp extends StatelessWidget {
  const FinoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: myAppTheme,
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              foregroundColor: Colors.white,
              backgroundColor: const Color(0xFF1E3A8A),
            ),
            scaffoldBackgroundColor: myAppTheme.kBackgroundColor,
            // primaryColor: Colors.white
          ),

          home: 
          HomeScreen(),
          //  FinoraScreen(),
        );
      },
    );
  }
}
