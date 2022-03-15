import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tracker_flutter/widgets/ShowAlertDialogue.dart';

Future<void> showExceptionAlertDialog(
  BuildContext context,
  String title,
  Exception exception,
) =>
    showAlertDialogue(context,
        title: title, content: _message(exception), defaultActionText: 'OK');

String _message(Exception exception) {
  if (exception is FirebaseException) {
    return exception.message!;
  }
  return exception.toString();
}
