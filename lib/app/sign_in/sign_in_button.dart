import 'package:flutter/material.dart';
import 'package:tracker_flutter/widgets/CustomElevatedButton.dart';

class SignInButton extends CustomElevatedButton {
  SignInButton({
    Key? key,
    required String text,
    Color color = Colors.white,
    Color? textColor,
    required VoidCallback onPressed,
  }) : super(
          key: key,
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 15.0),
          ),
          color: color,
          onPressed: onPressed,
        );
}
