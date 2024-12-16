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
    apiKey: 'AIzaSyBdSmhOSlBIiGoDsKN-HFLTuoF_r0GFod4',
    appId: '1:359036584876:web:48aeace1db0720750b7009',
    messagingSenderId: '359036584876',
    projectId: 'app-pokemon-2e208',
    authDomain: 'app-pokemon-2e208.firebaseapp.com',
    databaseURL: 'https://app-pokemon-2e208-default-rtdb.firebaseio.com',
    storageBucket: 'app-pokemon-2e208.firebasestorage.app',
    measurementId: 'G-54HV8KST76',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCwQiEPjtib6cvXLrK0OceCdq9zZqlBhl8',
    appId: '1:359036584876:android:dc809603ebc47be80b7009',
    messagingSenderId: '359036584876',
    projectId: 'app-pokemon-2e208',
    databaseURL: 'https://app-pokemon-2e208-default-rtdb.firebaseio.com',
    storageBucket: 'app-pokemon-2e208.firebasestorage.app',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDcR9BSNgO3iza-HhRL6swxEPjsuBWpVIw',
    appId: '1:359036584876:web:050913821c4052910b7009',
    messagingSenderId: '359036584876',
    projectId: 'app-pokemon-2e208',
    authDomain: 'app-pokemon-2e208.firebaseapp.com',
    databaseURL: 'https://app-pokemon-2e208-default-rtdb.firebaseio.com',
    storageBucket: 'app-pokemon-2e208.firebasestorage.app',
    measurementId: 'G-6Q7MH400L5',
  );
}