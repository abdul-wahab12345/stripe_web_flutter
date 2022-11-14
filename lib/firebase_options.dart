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
    apiKey: 'AIzaSyCDz0x_Ok-FE6EhaqHGGlt2ctnDTvv39A8',
    appId: '1:88352707220:web:c0d65286614486e9f39a81',
    messagingSenderId: '88352707220',
    projectId: 'stripe-8741d',
    authDomain: 'stripe-8741d.firebaseapp.com',
    storageBucket: 'stripe-8741d.appspot.com',
    measurementId: 'G-VM7D2GXPTP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBBs2BGL10NRxdnafKWcpMI3uI6f144BWQ',
    appId: '1:88352707220:android:1ac348b77c4c0f01f39a81',
    messagingSenderId: '88352707220',
    projectId: 'stripe-8741d',
    storageBucket: 'stripe-8741d.appspot.com',
  );
}
