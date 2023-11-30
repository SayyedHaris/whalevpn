import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whale_vpn/helper/helper.dart';
import 'package:whale_vpn/pages/authservice.dart';

import 'package:whale_vpn/pages/loginpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  final user = FirebaseAuth.instance.currentUser;

  final photo = FirebaseAuth.instance.currentUser!.photoURL;

  void signUserOut() async {
    if (FirebaseAuth.instance.currentUser != null) {
      AuthService().disconnectWithGoogle();
      await FirebaseAuth.instance.signOut();
      await Helper.rmClean();
      Get.to(const LoginPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Welcome to HomePage"),
        actions: [
          IconButton(
              onPressed: () async {
                signUserOut();

              },
              icon: const Icon(Icons.arrow_back_outlined)),
        ],
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          photo != null ?
          ClipOval(
            child: CircleAvatar(
                radius: 100,
                child: Image.network(photo.toString(),fit: BoxFit.fill,width: 200,)),
          ) : const Icon(Icons.account_circle, size: 100),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Logged In as :"),
              const SizedBox(
                width: 7,
              ),
              Text("${user!.email}",style: TextStyle(color: Colors.blue,fontSize: 16,fontWeight: FontWeight.bold),),

            ],
          )
        ],
      )),
    );
  }
}
