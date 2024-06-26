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
    apiKey: 'AIzaSyBFg_DrIT2JHk4REIwli7MlrQEloyaJwoo',
    appId: '1:399494570165:web:4f2af1855bf036e5089efc',
    messagingSenderId: '399494570165',
    projectId: 'messenger-5d2c7',
    authDomain: 'messenger-5d2c7.firebaseapp.com',
    storageBucket: 'messenger-5d2c7.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDUgPBUrWdpyStEjbQl_XjOAQLojS4VHZo',
    appId: '1:399494570165:android:7c02fae89209648d089efc',
    messagingSenderId: '399494570165',
    projectId: 'messenger-5d2c7',
    storageBucket: 'messenger-5d2c7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDgZsMFkJOKrAfAzQv7bDb30kO82nHozC4',
    appId: '1:399494570165:ios:763115892370a6ff089efc',
    messagingSenderId: '399494570165',
    projectId: 'messenger-5d2c7',
    storageBucket: 'messenger-5d2c7.appspot.com',
    iosBundleId: 'com.example.messengerTestTask',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDgZsMFkJOKrAfAzQv7bDb30kO82nHozC4',
    appId: '1:399494570165:ios:763115892370a6ff089efc',
    messagingSenderId: '399494570165',
    projectId: 'messenger-5d2c7',
    storageBucket: 'messenger-5d2c7.appspot.com',
    iosBundleId: 'com.example.messengerTestTask',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBFg_DrIT2JHk4REIwli7MlrQEloyaJwoo',
    appId: '1:399494570165:web:f15edbc3af11c639089efc',
    messagingSenderId: '399494570165',
    projectId: 'messenger-5d2c7',
    authDomain: 'messenger-5d2c7.firebaseapp.com',
    storageBucket: 'messenger-5d2c7.appspot.com',
  );

}