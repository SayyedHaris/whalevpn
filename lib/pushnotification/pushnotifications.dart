

import 'package:firebase_messaging/firebase_messaging.dart';


// Future<void> handleBackgroundMessage(RemoteMessage message)async {
//   print("Title : ${message.notification?.title}");
//   print("Body : ${message.notification?.body}");
//   print("Payload : ${message.data}");
// }

class PushNotification {

  final _pushNotifcation = FirebaseMessaging.instance;

  Future<void> initNotification () async {

    await _pushNotifcation.requestPermission();

    final fCMToken = await _pushNotifcation.getToken();

    print("Token : ${fCMToken}" );

    // FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

}