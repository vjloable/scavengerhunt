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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAA68ZDUYiH3hR7XJ9dDs75J0JIsGoe2qE',
    appId: '1:584010693194:web:ac6afa205c34c48d4104b3',
    messagingSenderId: '584010693194',
    projectId: 'scavengerhunt-effe1',
    authDomain: 'scavengerhunt-effe1.firebaseapp.com',
    databaseURL: 'https://scavengerhunt-effe1-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'scavengerhunt-effe1.appspot.com',
    measurementId: 'G-YBF6PH5YFQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDWjxIT58djJBhxxO7vhXrvMl5GUZs5wpg',
    appId: '1:584010693194:android:e4d6ae22137978d34104b3',
    messagingSenderId: '584010693194',
    projectId: 'scavengerhunt-effe1',
    databaseURL: 'https://scavengerhunt-effe1-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'scavengerhunt-effe1.appspot.com',
  );
}
