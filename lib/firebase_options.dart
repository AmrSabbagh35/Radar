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
    apiKey: 'AIzaSyB1Icy-Shls6GolxMBGe7v1dvrmwD4q9pU',
    appId: '1:929953137285:web:7bcb7de566a586c30a9fec',
    messagingSenderId: '929953137285',
    projectId: 'earthquake-8f6fc',
    authDomain: 'earthquake-8f6fc.firebaseapp.com',
    storageBucket: 'earthquake-8f6fc.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC_IBpttQNajFENRxdTJuzV7juVoSlwV_E',
    appId: '1:929953137285:android:427c353e2d6193b90a9fec',
    messagingSenderId: '929953137285',
    projectId: 'earthquake-8f6fc',
    storageBucket: 'earthquake-8f6fc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBMmS-D_YnaN30Un4vjIW39gbaYSQkRA4o',
    appId: '1:929953137285:ios:765032cc7d9e6ce70a9fec',
    messagingSenderId: '929953137285',
    projectId: 'earthquake-8f6fc',
    storageBucket: 'earthquake-8f6fc.appspot.com',
    iosClientId: '929953137285-kc4qjo2mm2ms61l7aoqttbn1ji1k6cl3.apps.googleusercontent.com',
    iosBundleId: 'com.example.earthquake',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBMmS-D_YnaN30Un4vjIW39gbaYSQkRA4o',
    appId: '1:929953137285:ios:9ff9bf5e51f6fc1b0a9fec',
    messagingSenderId: '929953137285',
    projectId: 'earthquake-8f6fc',
    storageBucket: 'earthquake-8f6fc.appspot.com',
    iosClientId: '929953137285-u3odrd2dfjc18am1p0eigp4baferqdjm.apps.googleusercontent.com',
    iosBundleId: 'com.example.earthquake.RunnerTests',
  );
}
