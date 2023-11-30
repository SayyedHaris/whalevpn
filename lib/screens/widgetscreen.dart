import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:whale_vpn/screens/profilescreen.dart';
import 'package:whale_vpn/screens/rowandcolumn.dart';
import 'package:whale_vpn/troggleEye/troggleeye.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {








  final TroggleEye _eye = Get.put(TroggleEye());

  late SharedPreferences prefs;


  RangeValues values = const RangeValues(0.0, 150.0);

  String groupValue = "Yes";
  bool isCheckedNo = false;
  bool isCheckedYes = false;
  String dropDownvalue = 'One';
  String popUpMenu = 'One';


  void initState() {
    super.initState();
    loadSliderValues();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(channel.id, channel.name,
                    channelDescription: channel.description,playSound: true, icon: "@mipmap/ic_launcher")));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? andriod = message.notification?.android;
      if (notification != null && andriod != null) {
        showDialog(context: context, builder:(context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Text(notification.body.toString())
                ],
              ),
            ),
            title: Text(notification.title.toString(),

            ),);

        }, );
      }
    });



  }

  void showNotification(){
    //
    flutterLocalNotificationsPlugin.show(0,
        "Testing",
        "How you doing",
        NotificationDetails(android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            importance: Importance.high,
            color: Colors.blue,
            playSound: true,
            icon: "@mipmap/ic_launcher"

        )));
  }

  // DateTime date = DateTime.now();
  Future<void> saveSliderValues() async {
    await prefs.setDouble('startValue', values.start);
    await prefs.setDouble('endValue', values.end);
  }



  Future<void> loadSliderValues() async {
    prefs = await SharedPreferences.getInstance();
    final double startValue = prefs.getDouble('startValue') ?? 0.0;
    final double endValue = prefs.getDouble('endValue') ?? 100.0;

    setState(() {
      values = RangeValues(startValue, endValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    RangeLabels labels =
        RangeLabels(values.start.toString(), values.end.toString());
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(

            title: const Text("Widgets",style: TextStyle(color: Colors.white),)),
        drawer: Drawer(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Center(
                    child: Text('Drawer Header',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30))),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Profile', style: TextStyle(fontSize: 18)),
                onTap: () {
                  Get.to(const ProfileScreen());
                },
              ),
              ListTile(
                leading: const Icon(Icons.radar),
                title: const Text('Row and Column', style: TextStyle(fontSize: 18)),
                onTap: () {
                  Get.to(const RowandColumn());
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.cyan.shade100,
            width: Get.width,
            height: Get.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
              child: Column(
                children: [
                  const Text("Text",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  padd,
                  TextField(
                    decoration: InputDecoration(
                        hintText: "Text Field",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25))),
                  ),
                  padd,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(180, 50)),
                          onPressed: () {

                            showNotification();


                          },
                          child: const Text("Push Notification Button")),
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Text Button",
                            style: TextStyle(fontSize: 22),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                          onPressed: () {},
                          child: const Text(
                            "Outlined Button",
                            style: TextStyle(fontSize: 21),
                          )),
                      const SizedBox(
                        width: 1,
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.settings,
                            size: 35,
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration:
                            const BoxDecoration(color: Colors.transparent),
                        width: 175,
                        height: 40,
                        child: RangeSlider(
                          labels: labels,
                          divisions: 10,
                          min: 0.0,
                          max: 150,
                          values: values,
                          onChanged: (value) {
                            values = value;
                            saveSliderValues();

                            setState(() {});
                          },
                        ),
                      ),
                      Radio(
                        value: "Yes",
                        groupValue: groupValue,
                        onChanged: (value) {
                          setState(() {
                            groupValue = value!;
                          });
                        },
                      ),
                      const SizedBox(
                        child: Text("Yes"),
                      ),
                      Radio(
                        value: "No",
                        groupValue: groupValue,
                        onChanged: (value) {
                          setState(() {
                            groupValue = value!;
                          });
                        },
                      ),
                      const SizedBox(
                        child: Text("No"),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: isCheckedNo,
                        onChanged: (value) {
                          setState(() {
                            isCheckedNo = value!;
                          });
                        },
                      ),
                      const SizedBox(
                        child: Text("Yes"),
                      ),
                      const SizedBox(
                        width: 18,
                      ),
                      Checkbox(
                        value: isCheckedYes,
                        onChanged: (value) {
                          setState(() {
                            isCheckedYes = value!;
                          });
                        },
                      ),
                      const SizedBox(
                        child: Text("No"),
                      ),
                      const SizedBox(
                        width: 138,
                      ),
                      DropdownButton<String>(
                        icon: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.menu),
                        ),
                        value: dropDownvalue,
                        underline: Container(
                          height: 2,
                          color: Colors.blue,
                        ),
                        style: const TextStyle(color: Colors.black),
                        items: const [
                          DropdownMenuItem<String>(
                            value: 'One',
                            child: Text("One"),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Two',
                            child: Text("Two"),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Three',
                            child: Text("Three"),
                          ),
                        ],
                        onChanged: (value) {
                          dropDownvalue = value!;
                          setState(() {});
                        },
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 27,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FloatingActionButton(
                        child: const Icon(Icons.add),
                        tooltip: "Floating Button",
                        onPressed: () {},
                      ),
                      PopupMenuButton(

                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [

                            Text("${popUpMenu}"),
                            SizedBox(width: 3,),

                            Icon(Icons.arrow_drop_down_circle_rounded),

                          ],
                        ),
                        onSelected: (value) {
                          popUpMenu = value;
                          setState(() {
                            print("Selected ${popUpMenu}");
                          });
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                              value: 'One',
                              child: Text("Option One")),
                          const PopupMenuItem(
                              value: 'Two',
                              child: Text("Option Two")),
                          const PopupMenuItem(
                              value: 'Three',
                              child: Text("Option Three")),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SlideAction(
                    outerColor: Colors.blue,
                    sliderButtonIcon: const Icon(Icons.lock_open),
                    sliderRotate: false,
                    text: "Slide to unlock",
                    textStyle:
                        const TextStyle(fontSize: 18, color: Colors.white),
                    onSubmit: ()  {

                        _eye.chooseDate();
                      // DateTime? newDate = await showDatePicker(
                      //   context: context,
                      //   initialDate: DateTime.now(),
                      //   firstDate: DateTime(2000),
                      //   lastDate: DateTime(2025),
                      // );

                      // if (newDate == null) {
                      //   return null;
                      // }

                      // setState(() => date = newDate);

                    },
                  ),
                  padd,
                  Obx(() => Text(DateFormat('dd-MM-yyyy').format(_eye.selectedDate.value).toString())),
                  // Text("${date.year}/${date.month}/${date.day}"),

                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("This is Alert Dialog Box"),
                                  content: Container(
                                    height: 50,
                                    width: 150,
                                    child: const Column(
                                      children: [
                                        Text("This is"),
                                        Text("Alert Box"),
                                      ],
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.all(10),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: const Text("Back")),
                                  ],
                                  icon: const Icon(Icons.sports_basketball),
                                );
                              },
                            );
                          },
                          child: const Text("Alert Dialog")),
                      IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Container(
                                    height: 250,
                                    width: 100,
                                    child: Center(
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: CircleAvatar(
                                              radius: 130,
                                              child: Image.asset(
                                                  "assets/images/whalevpn.png"))),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.photo_album,
                            color: Colors.black,
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget padd = SizedBox(height: 30);
