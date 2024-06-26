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
    apiKey: 'AIzaSyCaCsjDXP9ordf-foHRQ1lgIQkRjB8B2Qo',
    appId: '1:947403689445:web:5dfad342a252e82c54330c',
    messagingSenderId: '947403689445',
    projectId: 'sample-firebase-70d8a',
    authDomain: 'sample-firebase-70d8a.firebaseapp.com',
    storageBucket: 'sample-firebase-70d8a.appspot.com',
    measurementId: 'G-FJS7DMS2PE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBMtVNjofBhkZ9BLnNzSSCQ-ZMj_evcMJ4',
    appId: '1:947403689445:android:c32b4f09c1fdbc9654330c',
    messagingSenderId: '947403689445',
    projectId: 'sample-firebase-70d8a',
    storageBucket: 'sample-firebase-70d8a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBs0_5Uls2TfUJerj2QM1P6pi1MFJoeSgw',
    appId: '1:947403689445:ios:a2c9a88392400d8454330c',
    messagingSenderId: '947403689445',
    projectId: 'sample-firebase-70d8a',
    storageBucket: 'sample-firebase-70d8a.appspot.com',
    iosBundleId: 'com.example.sampleFirebase',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBs0_5Uls2TfUJerj2QM1P6pi1MFJoeSgw',
    appId: '1:947403689445:ios:a2c9a88392400d8454330c',
    messagingSenderId: '947403689445',
    projectId: 'sample-firebase-70d8a',
    storageBucket: 'sample-firebase-70d8a.appspot.com',
    iosBundleId: 'com.example.sampleFirebase',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCaCsjDXP9ordf-foHRQ1lgIQkRjB8B2Qo',
    appId: '1:947403689445:web:d2e6d2135692b72f54330c',
    messagingSenderId: '947403689445',
    projectId: 'sample-firebase-70d8a',
    authDomain: 'sample-firebase-70d8a.firebaseapp.com',
    storageBucket: 'sample-firebase-70d8a.appspot.com',
    measurementId: 'G-K3FKMEF935',
  );
}
