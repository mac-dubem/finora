import 'package:finora/screens/finora_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(FinoraApp());
}

class FinoraApp extends StatelessWidget {
  const FinoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF1976D2),
        ),
        scaffoldBackgroundColor: Colors.white,
        // primaryColor: Colors.white
      ),

      home: FinoraScreen()
    );
  }
}
