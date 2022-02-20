import 'package:flutter/material.dart';
import 'package:tracker_flutter/widgets/CustomElevatedButton.dart';

class SocialSignInButton extends CustomElevatedButton {
  SocialSignInButton({
    Key? key,
    required String assetName,
    required String text,
    Color color = Colors.white,
    Color? textColor,
    required VoidCallback onPressed,
  }) : super(
          key: key,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                assetName,
                semanticLabel: text,
                width: 24.0,
                height: 24.0,
              ),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(color: textColor, fontSize: 16.0),
              ),
              Opacity(
                  opacity: 0.0,
                  child: Image.asset(
                    assetName,
                    width: 24.0,
                    height: 24.0,
                  )),
            ],
          ),
          color: color,
          onPressed: onPressed,
        );
}
