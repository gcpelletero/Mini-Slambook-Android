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
    apiKey: 'AIzaSyAEgtisBfi0zneYJnOVQiHeT_LFe5tQG_8',
    appId: '1:1022022054863:web:a60685cbb663bd8a2318ba',
    messagingSenderId: '1022022054863',
    projectId: 'cmsc23-exer8-app-gcpelletero',
    authDomain: 'cmsc23-exer8-app-gcpelletero.firebaseapp.com',
    storageBucket: 'cmsc23-exer8-app-gcpelletero.appspot.com',
    measurementId: 'G-S9K91JV4E7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCRx5joJ5zq0NBFn-EdF8bFsUzaNoFim60',
    appId: '1:1022022054863:android:50632377441b079c2318ba',
    messagingSenderId: '1022022054863',
    projectId: 'cmsc23-exer8-app-gcpelletero',
    storageBucket: 'cmsc23-exer8-app-gcpelletero.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAjAnJJ21kBqRsYMXQ88tmtfAIDpTzFik8',
    appId: '1:1022022054863:ios:acad05df4d962fe02318ba',
    messagingSenderId: '1022022054863',
    projectId: 'cmsc23-exer8-app-gcpelletero',
    storageBucket: 'cmsc23-exer8-app-gcpelletero.appspot.com',
    iosBundleId: 'com.example.week4FlutterApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAjAnJJ21kBqRsYMXQ88tmtfAIDpTzFik8',
    appId: '1:1022022054863:ios:acad05df4d962fe02318ba',
    messagingSenderId: '1022022054863',
    projectId: 'cmsc23-exer8-app-gcpelletero',
    storageBucket: 'cmsc23-exer8-app-gcpelletero.appspot.com',
    iosBundleId: 'com.example.week4FlutterApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAEgtisBfi0zneYJnOVQiHeT_LFe5tQG_8',
    appId: '1:1022022054863:web:2ea6b407e6cee6f42318ba',
    messagingSenderId: '1022022054863',
    projectId: 'cmsc23-exer8-app-gcpelletero',
    authDomain: 'cmsc23-exer8-app-gcpelletero.firebaseapp.com',
    storageBucket: 'cmsc23-exer8-app-gcpelletero.appspot.com',
    measurementId: 'G-SHGHB7NRV3',
  );
}
