import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  const MyButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 6, 9, 20), // yoru0
        borderRadius: BorderRadiusDirectional.circular(8), // za zaobljene ivice
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Color.fromARGB(255, 189, 191, 203), // tsuki3
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
