

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';


Future<void> handleBackgroundMessage(RemoteMessage message)async {
  print("Title : ${message.notification?.title}");
  print("Body : ${message.notification?.body}");
  print("Payload : ${message.data}");
}

class PushNotification {

  final _pushNotifcation = FirebaseMessaging.instance;

  Future<void> initNotification () async {

    NotificationSettings settings = await _pushNotifcation.requestPermission();


    await _pushNotifcation.requestPermission();

    final fCMToken = await _pushNotifcation.getToken();

    print("Token : ${fCMToken}" );

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("Authorized Successfully");

    }
    else{
      openAppSettings();
    }
  }

}



//
// class NotificationServices {
//
//   FirebaseMessaging messaging =FirebaseMessaging.instance;
//
//   void requestNotificationPermission() async{
//     NotificationSettings settings =  await messaging.requestPermission(
//       alert: true,
//       // announcement: true,
//       badge: true,
//       sound: true,
//       // provisional: true
//     );
//
//     final token = await messaging.getToken();
//
//
//   }
// }