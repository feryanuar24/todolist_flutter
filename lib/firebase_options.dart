import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA1w9wGunc75iapSXXSQ-H5KwgxZMvia6Y',
    authDomain: 'todolist-flutter-7d3f8.firebaseapp.com',
    projectId: 'todolist-flutter-7d3f8',
    storageBucket: 'todolist-flutter-7d3f8.firebasestorage.app',
    messagingSenderId: '902200913123',
    appId: '1:902200913123:web:f6e503a752fc373919e9d6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA1w9wGunc75iapSXXSQ-H5KwgxZMvia6Y',
    appId: '1:902200913123:android:be3bf3ceffa0c29b19e9d6',
    messagingSenderId: '902200913123',
    projectId: 'todolist-flutter-7d3f8',
    storageBucket: 'todolist-flutter-7d3f8.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'your-ios-api-key',
    appId: 'your-ios-app-id',
    messagingSenderId: '902200913123',
    projectId: 'todolist-flutter-7d3f8',
    storageBucket: 'todolist-flutter-7d3f8.firebasestorage.app',
    iosBundleId: 'your.ios.bundle.id',
  );
}
