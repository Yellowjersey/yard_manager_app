import 'package:flutter/material.dart';

class custom_elevated_button extends StatelessWidget {
  const custom_elevated_button({
    required this.onPressed,
    required this.buttonText,
    required this.backgroundColor,
    required this.foregroundColor,
    super.key,
  });

  final void Function() onPressed;
  final String buttonText;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
        foregroundColor:
            MaterialStateColor.resolveWith((Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.grey;
          }
          return foregroundColor;
        }),
      ),
      onPressed: onPressed,
      child: Text(buttonText),
    );
  }
}
