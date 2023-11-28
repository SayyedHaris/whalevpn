import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whale_vpn/apis/apimodel.dart';
import 'package:whale_vpn/helper/helper.dart';
import 'package:whale_vpn/pages/authservice.dart';
import 'package:whale_vpn/pages/emailandpassword.dart';
import 'package:whale_vpn/pages/homepage.dart';

import 'package:whale_vpn/pages/signuppage.dart';

import 'package:whale_vpn/pages/verificationpage.dart';
import 'package:whale_vpn/screens/rowandcolumn.dart';

import '../troggleEye/troggleeye.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

final emailController = TextEditingController();
final passController = TextEditingController();






void signUserIn()async {
  try{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passController.text);
    print("Successfull");
    Get.to(HomePage());

  }catch(e){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter correct Details")));
    print(e);
  }
}




  final TroggleEye _eye = Get.put(TroggleEye());
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  void _submitForm(){
    if (_formkey.currentState!.validate()) {
      print("harry");
      Get.to(HomePage());
    }  else{
      Get.snackbar("Sorry", "Fill the form properly");
    }
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .07,
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                          height: Get.height * .18,
                          width: Get.width * 5,
                          child: CircleAvatar(
                              backgroundColor: Colors.grey.shade600.withOpacity(0.1))),
                      SizedBox(
                          height: Get.height * .01,
                          width: Get.width * .01,
                          child: const CircleAvatar(
                            backgroundColor: Colors.white,
                          )),
                      SizedBox(
                          height: Get.height * .13,
                          width: Get.width * .27,
                          child: const CircleAvatar(
                            backgroundImage: AssetImage(
                              "assets/images/whalevpn.png",
                            ),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: "Whale",
                                style: TextStyle(
                                    color: Colors.blue.shade700,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40)),
                            const TextSpan(
                              text: " VPN",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * .04,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    height: Get.height * .08,
                    width: Get.width * .9,
                    child: TabBar(
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          30.0,
                        ),
                        color: Colors.blue.shade800,
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.grey.shade900,
                      tabs: const [
                        Tab(
                          child: Text("Log In", style: TextStyle(fontSize: 19)),
                        ),
                        Tab(
                          child: Text("Sign Up", style: TextStyle(fontSize: 19)),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    height: Get.height * 6, // Adjust the height as needed
                    child: TabBarView(
                      children: [
                        ListView(keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Column(
                                children: [
                                  TextFormField(

                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please enter email";
                                      }
                                      RegExp emailReg = RegExp(
                                          r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}');
                                      if (!emailReg.hasMatch(value)) {
                                        return "Please provide valid email";
                                      }
                                    },
                                    controller: emailController,
                                    decoration: InputDecoration(
                                      disabledBorder: const OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(30)),
                                      prefixIcon: const Icon(
                                          Icons.alternate_email,
                                          size: 25,
                                          color: Colors.grey),
                                      labelText: "Email Address",
                                      labelStyle:
                                      const TextStyle(color: Colors.black),
                                      hintText: "Enter email address",
                                      contentPadding: const EdgeInsets.symmetric(
                                        vertical: 25,
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(30)),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Obx(() {
                                    return TextFormField(
                                      obscureText: !_eye.isVisible.value,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Enter password";
                                        } else if (value!.length <= 5) {
                                          return "Password must contain 5 characters";
                                        }
                                      },
                                      controller: passController,
                                      decoration: InputDecoration(
                                        disabledBorder: const OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(30)),

                                        prefixIcon: const Icon(
                                            Icons.password_outlined,
                                            size: 25,
                                            color: Colors.grey),
                                        labelText: "Password",
                                        labelStyle:
                                        const TextStyle(color: Colors.black),
                                        hintText: "Enter password",
                                        suffixIcon: Obx(() {
                                          return IconButton(
                                            onPressed: () {
                                              _eye.TroggleSwitch();
                                            },
                                            icon: Icon(_eye.isVisible.value ? Icons.visibility : Icons.visibility_off),
                                          );
                                        }),
                                        contentPadding: const EdgeInsets.symmetric(
                                          vertical: 25,
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(30)),
                                      ),
                                    );
                                  }),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18, vertical: 8),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: TextButton(
                                        onPressed: () {
                                          Get.to(const VerificationPage());
                                        },
                                        child: const Text(
                                          "Forget your password?",
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [

                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.white,
                                                  shape: const StadiumBorder()),
                                              onPressed: () async {


                                                Apis().handleGoogleButtonClick();
                                                Helper.saveUserData(true);


                                            // AuthService().signInWithGoogle();


                                          }, child: Row(
                                            children: [
                                             Container(
                                               child: Image.asset("assets/images/google.png"),
                                               height: 40,width: 40,),
                                              const Text("Login with Google",style: TextStyle(color: Colors.black),),
                                            ],
                                          ))
                                    ],
                                  ),
                                  const SizedBox(height: 8,),
                                  const Row(
                                    children: [
                                      Expanded(child: Divider(thickness: 2,)),
                                      Text("  Or try with  "),
                                      Expanded(child: Divider(thickness: 2,))
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 17),
                                    child: Stack(
                                      children: [
                                        ElevatedButton(
                                            onPressed: () async {
                                              signUserIn();
                                            Helper.saveUserData(true);

                                            // _submitForm();
                                            },
                                            style: ElevatedButton.styleFrom(
                                                minimumSize: Size(
                                                    Get.width,
                                                    Get.height * .075),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        20))),
                                            child: const Text(
                                              "Log in",
                                              style: TextStyle(fontSize: 20),
                                            )),
                                        Positioned(
                                          right: 20,
                                          bottom: 12,
                                          child: MaterialButton(
                                            shape: const StadiumBorder(),
                                            minWidth: 20,
                                            height: 40,
                                            color: Colors.white70,
                                            child: const Icon(Icons.arrow_forward),
                                            onPressed: () {
                                              _submitForm();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),
                         const SignUpPage()
                      ],
                    ),
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
