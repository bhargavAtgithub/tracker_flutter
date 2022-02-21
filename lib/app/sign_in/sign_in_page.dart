import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tracker_flutter/app/sign_in/sign_in_button.dart';
import 'package:tracker_flutter/app/sign_in/social_sign_in_button.dart';
import 'package:tracker_flutter/services/auth.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key, required this.auth, required this.onSignIn})
      : super(key: key);
  final AuthBase auth;
  final void Function(User?) onSignIn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[50],
      // appBar: AppBar(
      //   title: const Text('Time Tracker'),
      //   elevation: 0,
      // ),
      body: BuildContent(auth: auth, onSignIn: onSignIn),
    );
  }
}

class BuildContent extends StatelessWidget {
  const BuildContent({Key? key, required this.auth, required this.onSignIn})
      : super(key: key);
  final AuthBase auth;
  final Function(User?) onSignIn;

  Future<void> _signInAnonymously() async {
    final User? user;
    try {
      user = await auth.signInAnonymously();
      onSignIn(user);
    } catch (err) {
      // ignore: avoid_print
      print(err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      // padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            "Tracker",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 48.0,
              fontWeight: FontWeight.w200,
              letterSpacing: 10,
              color: Colors.cyan,
            ),
          ),
          const SizedBox(
            height: 110.0,
          ),
          SocialSignInButton(
            assetName: 'images/google-logo.png',
            text: 'Sign in with google',
            textColor: Colors.black87,
            onPressed: () {},
          ),
          const SizedBox(
            height: 8.0,
          ),
          SocialSignInButton(
            assetName: 'images/meta-logo.png',
            text: 'Sign in with meta',
            textColor: Colors.white,
            color: const Color.fromARGB(255, 100, 140, 248),
            onPressed: () {},
          ),
          const SizedBox(
            height: 8.0,
          ),
          SignInButton(
            text: 'Sign in with email',
            textColor: Colors.white,
            color: Colors.teal[400]!,
            onPressed: () {},
          ),
          const SizedBox(
            height: 8.0,
          ),
          const Text(
            'or',
            style: TextStyle(
                fontSize: 14.0,
                color: Colors.black87,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 8.0,
          ),
          SignInButton(
            text: 'Go anonymous',
            textColor: Colors.white,
            color: Colors.black54,
            onPressed: _signInAnonymously,
          ),
        ],
      ),
    );
  }
}
