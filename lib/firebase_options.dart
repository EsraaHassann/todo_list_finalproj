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
    apiKey: 'AIzaSyAxjuU-mG8JpX2BnOBvIY_W7prjjSwQMsg',
    appId: '1:1032816854236:web:3bfbc5074646184a46e019',
    messagingSenderId: '1032816854236',
    projectId: 'todo-list-3b0df',
    authDomain: 'todo-list-3b0df.firebaseapp.com',
    storageBucket: 'todo-list-3b0df.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCMri5Mrg5nEmlPyPGcIQtoMqgdHmXd6W0',
    appId: '1:1032816854236:android:c1b47da99886e6fb46e019',
    messagingSenderId: '1032816854236',
    projectId: 'todo-list-3b0df',
    storageBucket: 'todo-list-3b0df.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDjkZO7rRz5Ru74iYrzBtLZyqRsxdGG5qM',
    appId: '1:1032816854236:ios:794dc7c5f53b10e546e019',
    messagingSenderId: '1032816854236',
    projectId: 'todo-list-3b0df',
    storageBucket: 'todo-list-3b0df.firebasestorage.app',
    iosBundleId: 'com.example.todoListFinalproj',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDjkZO7rRz5Ru74iYrzBtLZyqRsxdGG5qM',
    appId: '1:1032816854236:ios:794dc7c5f53b10e546e019',
    messagingSenderId: '1032816854236',
    projectId: 'todo-list-3b0df',
    storageBucket: 'todo-list-3b0df.firebasestorage.app',
    iosBundleId: 'com.example.todoListFinalproj',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAxjuU-mG8JpX2BnOBvIY_W7prjjSwQMsg',
    appId: '1:1032816854236:web:8219a2b90085f17f46e019',
    messagingSenderId: '1032816854236',
    projectId: 'todo-list-3b0df',
    authDomain: 'todo-list-3b0df.firebaseapp.com',
    storageBucket: 'todo-list-3b0df.firebasestorage.app',
  );

}