import 'package:flutter/material.dart';
import 'package:tracker_flutter/app/landing_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tracker_flutter/services/auth.dart';
import 'firebase_options.dart';

// Define entry point of our application
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const TrackerApp());
}

class TrackerApp extends StatelessWidget {
  const TrackerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Time Tracker",
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: LandingPage(
        auth: Auth(),
      ),
    );
  }
}
