import 'package:flutter/material.dart';
import 'package:tracker_flutter/app/sign_in/email_sign_in_form.dart';
import 'package:tracker_flutter/services/auth.dart';

class EmailSignInPage extends StatelessWidget {
  const EmailSignInPage({
    Key? key,
    required this.auth,
  }) : super(key: key);

  final AuthBase auth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // title: const Text('Time Tracker'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: EmailSignInForm(
              auth: auth,
            ),
            elevation: 8,
            // shadowColor: Colors.teal[400],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),
    );
  }
}
