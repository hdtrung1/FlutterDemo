// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyByYvj7DV3MBm4bW23iK2b2RdpL2up5XHA',
    appId: '1:317483636379:web:ffbef81b6ef6d232d2183e',
    messagingSenderId: '317483636379',
    projectId: 'flutter-demo-5fa52',
    authDomain: 'flutter-demo-5fa52.firebaseapp.com',
    storageBucket: 'flutter-demo-5fa52.appspot.com',
    measurementId: 'G-PW51X9DC79',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAX7cQoQuNA8wnj8bV23ISUeZHV4ByBIo4',
    appId: '1:317483636379:android:7fb14e9b7c59e2fad2183e',
    messagingSenderId: '317483636379',
    projectId: 'flutter-demo-5fa52',
    storageBucket: 'flutter-demo-5fa52.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBIYpUMBCIBiEHS56pB5iAVEBGbN4sI-IM',
    appId: '1:317483636379:ios:73e9c134ddbd58bad2183e',
    messagingSenderId: '317483636379',
    projectId: 'flutter-demo-5fa52',
    storageBucket: 'flutter-demo-5fa52.appspot.com',
    iosBundleId: 'com.example.flutterDemo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBIYpUMBCIBiEHS56pB5iAVEBGbN4sI-IM',
    appId: '1:317483636379:ios:1d8fbe228148b79bd2183e',
    messagingSenderId: '317483636379',
    projectId: 'flutter-demo-5fa52',
    storageBucket: 'flutter-demo-5fa52.appspot.com',
    iosBundleId: 'com.example.flutterDemo.RunnerTests',
  );
}
