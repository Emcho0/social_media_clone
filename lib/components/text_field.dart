import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {

  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  const MyTextField({super.key,
                      required this.controller,
                      required this.hintText,
                      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black)
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black)
        ),
        fillColor: Color.fromARGB(255, 135, 137, 150),
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(color: Color.fromARGB(255, 6,9,14)),
      ),
    );
  }
}