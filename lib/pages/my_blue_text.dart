import 'package:flutter/material.dart';

class MyBlueText extends StatelessWidget {
  const MyBlueText(this.text,{super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text,
    style: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
      ),
    );
  }
}