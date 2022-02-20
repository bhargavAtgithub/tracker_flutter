import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.onSignOut}) : super(key: key);

  final VoidCallback onSignOut;

  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      onSignOut();
    } catch (err) {
      // ignore: avoid_print
      print(err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: _signOut,
              child: const Text("Logout",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)))
        ],
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        elevation: 0,
        title: const Text("Tracker"),
        centerTitle: false,
        bottom: PreferredSize(
            child: Container(
              color: const Color.fromARGB(255, 0, 0, 0),
              height: 0.2,
            ),
            preferredSize: const Size.fromHeight(4.0)),
      ),
      body: const Center(child: Text("Content")),
    );
  }
}
