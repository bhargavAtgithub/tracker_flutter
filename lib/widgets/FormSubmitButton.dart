import 'package:flutter/material.dart';
import 'package:tracker_flutter/widgets/CustomElevatedButton.dart';

class FormSubmitButton extends CustomElevatedButton {
  FormSubmitButton({
    Key? key,
    required String text,
    required VoidCallback? onPressed,
  }) : super(
            key: key,
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            onPressed: onPressed,
            height: 44.0,
            color: Colors.teal[400]!);
}
