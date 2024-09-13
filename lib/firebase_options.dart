import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    throw UnsupportedError('DefaultFirebaseOptions are not supported for this platform.');
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBVn7W5JsCGtJJtu-vcQd8PCOYSYzd92Ls',
    appId: '1:351018466916:web:6c3451dc10f30155b6a971',
    messagingSenderId: '351018466916',
    projectId: 'flutter-app-int',
    authDomain: 'flutter-app-int.firebaseapp.com',
    databaseURL: 'https://flutter-app-int-default-rtdb.firebaseio.com/', // Asegúrate de que esta URL sea correcta
    storageBucket: 'flutter-app-int.appspot.com',
  );
}
