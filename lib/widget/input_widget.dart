import 'package:finora/constant.dart';
import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  const InputWidget({
    super.key,
    required this.hint,
    this.keyboardType,
    required this.controller,
  });

  final String hint;
  final TextInputType? keyboardType;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: myAppTheme.kContainerColor,
          borderRadius: BorderRadius.circular(8),
          // border: Border.all(color: Colors.grey),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: TextStyle(fontSize: 15, color:  myAppTheme.kContainerTextColor),
          
            // cursorColor: myAppTheme.kHighlightColor,
            
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(bottom: 10),
              hintText: hint, //"What was this for?",
              hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
}
