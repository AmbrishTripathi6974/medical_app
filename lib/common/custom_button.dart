import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final VoidCallback onPress;

  const CustomButton({
    required this.buttonText,
    required this.buttonColor,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        primary: buttonColor,
      ),
      child: Text(buttonText),
    );
  }
}