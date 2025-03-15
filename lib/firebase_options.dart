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
    apiKey: 'AIzaSyAah3_026u-dlgk052wfHI7QCBmcsbJGgA',
    appId: '1:121643950182:web:f350062f371b9015610da7',
    messagingSenderId: '121643950182',
    projectId: 'frogames-gpt',
    authDomain: 'frogames-gpt.firebaseapp.com',
    storageBucket: 'frogames-gpt.firebasestorage.app',
    measurementId: 'G-SSD1XPFKXE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDlNVepeEfe3fLILF6YaU7JCn_zCmt5fio',
    appId: '1:121643950182:android:8294dcd664b56657610da7',
    messagingSenderId: '121643950182',
    projectId: 'frogames-gpt',
    storageBucket: 'frogames-gpt.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA37rSLfACH6RkfOmaEWxTsBSMUnFW7TnQ',
    appId: '1:121643950182:ios:4fedc2cdba842312610da7',
    messagingSenderId: '121643950182',
    projectId: 'frogames-gpt',
    storageBucket: 'frogames-gpt.firebasestorage.app',
    iosBundleId: 'com.example.aiChatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA37rSLfACH6RkfOmaEWxTsBSMUnFW7TnQ',
    appId: '1:121643950182:ios:4fedc2cdba842312610da7',
    messagingSenderId: '121643950182',
    projectId: 'frogames-gpt',
    storageBucket: 'frogames-gpt.firebasestorage.app',
    iosBundleId: 'com.example.aiChatApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAah3_026u-dlgk052wfHI7QCBmcsbJGgA',
    appId: '1:121643950182:web:b67a66214a587517610da7',
    messagingSenderId: '121643950182',
    projectId: 'frogames-gpt',
    authDomain: 'frogames-gpt.firebaseapp.com',
    storageBucket: 'frogames-gpt.firebasestorage.app',
    measurementId: 'G-HMGWBZLCXP',
  );
}
