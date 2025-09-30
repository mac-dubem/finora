import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  const InputWidget({super.key, required this.hint, this.keyboardType});

  final String hint;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            keyboardType: keyboardType,
            style: TextStyle(fontSize: 15),
            decoration: InputDecoration(
              // enabledBorder: OutlineInputBorder(
              //   borderSide: BorderSide(color: Colors.grey, width: 1),
              //   borderRadius: BorderRadius.circular(10),
              // ),
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
