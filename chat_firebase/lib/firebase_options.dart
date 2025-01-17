// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyD1CzOwhCVXxcPvhU-ErwD5VzpO6aTNuZE',
    appId: '1:259149994361:web:e85da6102787797ee8f7a8',
    messagingSenderId: '259149994361',
    projectId: 'chat-firebase-5f5f3',
    authDomain: 'chat-firebase-5f5f3.firebaseapp.com',
    storageBucket: 'chat-firebase-5f5f3.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB4TcOuE0JNj13rkaaQyocKZD6IcmODivY',
    appId: '1:75093446515:android:d50f98fb31ca6ba655ff06',
    messagingSenderId: '75093446515',
    projectId: 'chat-firebase-2-a5e0e',
    storageBucket: 'chat-firebase-2-a5e0e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAXAS4u4f04kINDFkl-ZmFaf5_41BD3aGs',
    appId: '1:75093446515:ios:d1e8d1154bf0f7b555ff06',
    messagingSenderId: '75093446515',
    projectId: 'chat-firebase-2-a5e0e',
    storageBucket: 'chat-firebase-2-a5e0e.appspot.com',
    iosBundleId: 'com.dmitrijurban.chatFirebase',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBw5j-BPEBcL1VYfbesJDcfcUk3ATdLL8w',
    appId: '1:259149994361:ios:fe459bc42549f1d6e8f7a8',
    messagingSenderId: '259149994361',
    projectId: 'chat-firebase-5f5f3',
    storageBucket: 'chat-firebase-5f5f3.appspot.com',
    iosBundleId: 'com.example.chatFirebase',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD1CzOwhCVXxcPvhU-ErwD5VzpO6aTNuZE',
    appId: '1:259149994361:web:b74c4219e45b1b49e8f7a8',
    messagingSenderId: '259149994361',
    projectId: 'chat-firebase-5f5f3',
    authDomain: 'chat-firebase-5f5f3.firebaseapp.com',
    storageBucket: 'chat-firebase-5f5f3.appspot.com',
  );
}