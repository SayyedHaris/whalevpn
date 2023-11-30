import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whale_vpn/helper/helper.dart';
import 'package:whale_vpn/pages/homepage.dart';
import 'package:whale_vpn/pages/loginpage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool isLogin = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Helper.getUserData().then((value){
      print("Harry");
      if (value!) {
        isLogin = value;
      }
    });
        loadData();

  }

  Future<Timer> loadData() async {
    return Timer(const Duration(milliseconds: 500), onDoneLoading);
  }

  onDoneLoading() async {
    print("Checking");
    if (isLogin) {
      Get.offAll(const HomePage());
    }  else {
      Get.offAll(const LoginPage());
    }
  }








  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(60)),
        child: CircleAvatar(
          
          radius: 150,
          child: Image.asset("assets/images/whalesp.png"),),
      )),
    );
  }
}



