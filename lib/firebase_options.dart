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
    apiKey: String.fromEnvironment(
      'WEB_API_KEY',
      defaultValue: 'your-web-api-key',
    ),
    authDomain: String.fromEnvironment(
      'AUTH_DOMAIN',
      defaultValue: 'todolist-flutter-7d3f8.firebaseapp.com',
    ),
    projectId: String.fromEnvironment(
      'PROJECT_ID',
      defaultValue: 'todolist-flutter-7d3f8',
    ),
    storageBucket: String.fromEnvironment(
      'STORAGE_BUCKET',
      defaultValue: 'todolist-flutter-7d3f8.firebasestorage.app',
    ),
    messagingSenderId: String.fromEnvironment(
      'MESSAGING_SENDER_ID',
      defaultValue: '902200913123',
    ),
    appId: String.fromEnvironment(
      'WEB_APP_ID',
      defaultValue: '1:902200913123:web:f6e503a752fc373919e9d6',
    ),
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: String.fromEnvironment(
      'ANDROID_API_KEY',
      defaultValue: 'your-android-api-key',
    ),
    appId: String.fromEnvironment(
      'ANDROID_APP_ID',
      defaultValue: '1:902200913123:android:8120bf40912c70e419e9d6',
    ),
    messagingSenderId: String.fromEnvironment(
      'MESSAGING_SENDER_ID',
      defaultValue: '902200913123',
    ),
    projectId: String.fromEnvironment(
      'PROJECT_ID',
      defaultValue: 'todolist-flutter-7d3f8',
    ),
    storageBucket: String.fromEnvironment(
      'STORAGE_BUCKET',
      defaultValue: 'todolist-flutter-7d3f8.firebasestorage.app',
    ),
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: String.fromEnvironment(
      'IOS_API_KEY',
      defaultValue: 'your-ios-api-key',
    ),
    appId: String.fromEnvironment(
      'IOS_APP_ID',
      defaultValue: 'your-ios-app-id',
    ),
    messagingSenderId: String.fromEnvironment(
      'MESSAGING_SENDER_ID',
      defaultValue: '902200913123',
    ),
    projectId: String.fromEnvironment(
      'PROJECT_ID',
      defaultValue: 'todolist-flutter-7d3f8',
    ),
    storageBucket: String.fromEnvironment(
      'STORAGE_BUCKET',
      defaultValue: 'todolist-flutter-7d3f8.firebasestorage.app',
    ),
    iosBundleId: String.fromEnvironment(
      'IOS_BUNDLE_ID',
      defaultValue: 'your.ios.bundle.id',
    ),
  );
}
