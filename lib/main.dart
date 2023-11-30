import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'package:flutter/services.dart';
import 'package:whale_vpn/firebase_options.dart';
import 'package:whale_vpn/pages/authpage.dart';
import 'package:whale_vpn/pages/loginpage.dart';
import 'package:whale_vpn/pages/splashscreen.dart';
import 'package:whale_vpn/screens/notificationapi.dart';








Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(message.notification?.title);
  print(message.notification?.body);
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  "high-importance_channel",
  "This is important notification",
  description: "This channel is used for important notification",
  importance: Importance.high,
  playSound: true,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();




void main() async {


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);


  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    badge: true,
    alert: true,
    sound: true,
  );

    FirebaseAPI().initNotification();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.transparent,


  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(

          appBarTheme: AppBarTheme(color: Colors.blue)),
      debugShowCheckedModeBanner: false,
      home: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme:
            ThemeData( primarySwatch: Colors.blue),
        home: const SplashScreen(),
      ),
    );
  }
}
