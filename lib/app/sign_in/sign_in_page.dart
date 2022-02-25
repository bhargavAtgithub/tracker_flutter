import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker_flutter/app/sign_in/email_sign_in_page.dart';
import 'package:tracker_flutter/app/sign_in/sign_in_button.dart';
import 'package:tracker_flutter/app/sign_in/social_sign_in_button.dart';
import 'package:tracker_flutter/services/auth.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[50],
      // appBar: AppBar(
      //   title: const Text('Time Tracker'),
      //   elevation: 0,
      // ),
      body: const BuildContent(),
    );
  }
}

class BuildContent extends StatelessWidget {
  const BuildContent({Key? key}) : super(key: key);

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase?>(context, listen: false);
      await auth?.signInAnonymously();
    } catch (err) {
      // ignore: avoid_print
      print(err.toString());
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase?>(context, listen: false);

      await auth?.signInWithGoogle();
    } catch (err) {
      // ignore: avoid_print
      print(err.toString());
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase?>(context, listen: false);

      await auth?.signInWithFacebook();
    } catch (err) {
      // ignore: avoid_print
      print(err.toString());
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(
        fullscreenDialog: true, builder: (context) => const EmailSignInPage()));
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
            onPressed: () => _signInWithGoogle(context),
          ),
          const SizedBox(
            height: 8.0,
          ),
          SocialSignInButton(
            assetName: 'images/meta-logo.png',
            text: 'Sign in with meta',
            textColor: Colors.white,
            color: const Color.fromARGB(255, 100, 140, 248),
            onPressed: () => _signInWithFacebook(context),
          ),
          const SizedBox(
            height: 8.0,
          ),
          SignInButton(
            text: 'Sign in with email',
            textColor: Colors.white,
            color: Colors.teal[400]!,
            onPressed: () => _signInWithEmail(context),
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
            onPressed: () => _signInAnonymously(context),
          ),
        ],
      ),
    );
  }
}
