import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker_flutter/app/home/index.dart';
import 'package:tracker_flutter/app/sign_in/sign_in_page.dart';
import 'package:tracker_flutter/services/auth.dart';

class LandingPage extends StatelessWidget {
  const  LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase?>(context, listen: false);
    return StreamBuilder<User?>(
      stream: auth?.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;

          if (user == null) {
            return SignInPage.create(context);
          }
          return const HomePage();
        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
