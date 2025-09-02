
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    // Add other platforms as needed.
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        // return android;
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for android - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.iOS:
        // return ios;
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDZddQnt6BD6yfqU6EK4B8LnRi_w5d7Sv8',
    appId: '1:22078748682:web:757a916d84e7479a6e07f3',
    messagingSenderId: '22078748682',
    projectId: 'shop-bfe0d',
    authDomain: 'shop-bfe0d.firebaseapp.com',
    storageBucket: 'shop-bfe0d.appspot.com',
  );
}
