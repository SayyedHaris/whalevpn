
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseAPI {

  final _firebaseMessaging = FirebaseMessaging.instance;

  // Future<void> handleBackgroundMessage(RemoteMessage message) async {
  //   print(message.notification?.title);
  //   print(message.notification?.body);
  //   print(message.notification?.body);
  // }

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print("Token : $fCMToken");

    // FirebaseMessaging.onBackgroundMessage((handleBackgroundMessage));



  }
}
