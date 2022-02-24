import 'package:flutter/material.dart';
import 'package:tracker_flutter/services/auth.dart';
import 'package:tracker_flutter/widgets/ShowAlertDialogue.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.auth}) : super(key: key);
  final AuthBase auth;

  Future<void> _signOut() async {
    try {
      await auth.signOut();
    } catch (err) {
      // ignore: avoid_print
      print(err.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialogue(context,
        title: 'Logout',
        content: 'Are you sure?',
        cancelActionText: 'Cancel',
        defaultActionText: 'Logout');
    if (didRequestSignOut == true) {
      _signOut();
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
              onPressed: () => _confirmSignOut(context),
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
