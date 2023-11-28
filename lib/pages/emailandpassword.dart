import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:whale_vpn/pages/loginpage.dart';

class EmailPasswordPage extends StatefulWidget {
  const EmailPasswordPage({Key? key}) : super(key: key);

  @override
  State<EmailPasswordPage> createState() => _EmailPasswordPageState();
}

class _EmailPasswordPageState extends State<EmailPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {
            Get.to(LoginPage());
          }, icon: Icon(Icons.back_hand))
        ],
        title: Text("Email and Password Page"),),
    );
  }
}
