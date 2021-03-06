// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAfvfLSGM7ritgWQgaQgTarSdOxbBuK65A',
    appId: '1:54690599787:web:251a0408ceaf5654faf22e',
    messagingSenderId: '54690599787',
    projectId: 'tracker-33ecb',
    authDomain: 'tracker-33ecb.firebaseapp.com',
    storageBucket: 'tracker-33ecb.appspot.com',
    measurementId: 'G-SR50F7PTBQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCk2VcNJCM4FHiaTSQS26gARXEfU8iBGMk',
    appId: '1:54690599787:android:087df9f26d383caafaf22e',
    messagingSenderId: '54690599787',
    projectId: 'tracker-33ecb',
    storageBucket: 'tracker-33ecb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAiVNEZ8HSLq-5p0RRpQpWps8cEFnctzhs',
    appId: '1:54690599787:ios:83d4af6a7e9b6823faf22e',
    messagingSenderId: '54690599787',
    projectId: 'tracker-33ecb',
    storageBucket: 'tracker-33ecb.appspot.com',
    androidClientId: '54690599787-e3frsr8fb2cpvoljk0ijq5nopbhumo27.apps.googleusercontent.com',
    iosClientId: '54690599787-0ttj9evho4aria2b1onfpsllssmetcms.apps.googleusercontent.com',
    iosBundleId: 'com.example.trackerFlutter',
  );
}
