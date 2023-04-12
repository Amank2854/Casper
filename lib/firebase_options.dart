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
    apiKey: 'AIzaSyCogrZsbxmgBRSCjlu8slXGpxhGA1eUjPg',
    appId: '1:404983897210:web:e75314c2b84aea3faf2fc3',
    messagingSenderId: '404983897210',
    projectId: 'casper-5a3e9',
    authDomain: 'casper-5a3e9.firebaseapp.com',
    storageBucket: 'casper-5a3e9.appspot.com',
    measurementId: 'G-V4GRP4E2K4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA6Sn1bFyX8jfveH1Vqc82ltesY8wb9N_Q',
    appId: '1:404983897210:android:abcf19c8cd0ac560af2fc3',
    messagingSenderId: '404983897210',
    projectId: 'casper-5a3e9',
    storageBucket: 'casper-5a3e9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD0a5XdG31qC2Zh-z19Lyiob58TcnVzObs',
    appId: '1:404983897210:ios:cd5f6e3b922039b7af2fc3',
    messagingSenderId: '404983897210',
    projectId: 'casper-5a3e9',
    storageBucket: 'casper-5a3e9.appspot.com',
    iosClientId:
        '404983897210-3v58j8and033apa5hlhorpg2tsv8l8kn.apps.googleusercontent.com',
    iosBundleId: 'com.dep.casper',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD0a5XdG31qC2Zh-z19Lyiob58TcnVzObs',
    appId: '1:404983897210:ios:cd5f6e3b922039b7af2fc3',
    messagingSenderId: '404983897210',
    projectId: 'casper-5a3e9',
    storageBucket: 'casper-5a3e9.appspot.com',
    iosClientId:
        '404983897210-3v58j8and033apa5hlhorpg2tsv8l8kn.apps.googleusercontent.com',
    iosBundleId: 'com.dep.casper',
  );
}
