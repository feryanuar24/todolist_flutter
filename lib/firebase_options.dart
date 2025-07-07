import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Firebase configuration using environment variables for security.
///
/// IMPORTANT: No default values are provided to prevent exposing sensitive data.
/// All environment variables must be provided via --dart-define or .env file.
///
/// Run with: ./run_with_env.bat (Windows) or ./run_with_env.sh (Linux/Mac)
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
    apiKey: String.fromEnvironment('WEB_API_KEY'),
    authDomain: String.fromEnvironment('AUTH_DOMAIN'),
    projectId: String.fromEnvironment('PROJECT_ID'),
    storageBucket: String.fromEnvironment('STORAGE_BUCKET'),
    messagingSenderId: String.fromEnvironment('MESSAGING_SENDER_ID'),
    appId: String.fromEnvironment('WEB_APP_ID'),
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: String.fromEnvironment('ANDROID_API_KEY'),
    appId: String.fromEnvironment('ANDROID_APP_ID'),
    messagingSenderId: String.fromEnvironment('MESSAGING_SENDER_ID'),
    projectId: String.fromEnvironment('PROJECT_ID'),
    storageBucket: String.fromEnvironment('STORAGE_BUCKET'),
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: String.fromEnvironment('IOS_API_KEY'),
    appId: String.fromEnvironment('IOS_APP_ID'),
    messagingSenderId: String.fromEnvironment('MESSAGING_SENDER_ID'),
    projectId: String.fromEnvironment('PROJECT_ID'),
    storageBucket: String.fromEnvironment('STORAGE_BUCKET'),
    iosBundleId: String.fromEnvironment('IOS_BUNDLE_ID'),
  );
}
