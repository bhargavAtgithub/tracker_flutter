import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tracker_flutter/app/home/index.dart';
import 'package:tracker_flutter/app/sign_in/sign_in_page.dart';
import 'package:tracker_flutter/services/auth.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key, required this.auth}) : super(key: key);
  final AuthBase auth;

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  User? _user;

  @override
  void initState() {
    super.initState();
    _updateUser(widget.auth.currentUser);
  }

  void _updateUser(User? user) {
    setState(() {
      _user = user;
    });
    // print(FirebaseAuth.instance.currentUser?.uid);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: widget.auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;

          if (user == null) {
            return SignInPage(
              auth: widget.auth,
              onSignIn: _updateUser,
            );
          }
          return HomePage(
            auth: widget.auth,
            onSignOut: () => _updateUser(null),
          );
        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
