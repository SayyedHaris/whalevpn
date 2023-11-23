import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whale_vpn/screens/signupscreen.dart';
import 'package:whale_vpn/troggleEye/troggleeye.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final TroggleEye _eye = Get.put(TroggleEye());

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  void _submitSignUpForm(){
    if (_formkey.currentState!.validate()) {
      Get.to(const SignUpScreen());
    }  else{
      Get.snackbar("Sorry", "Fill the form properly");
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Form(
        key: _formkey,
        child: ListView(keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(

                horizontal: Get.width * .06
              ),
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                    if (value!.isEmpty) {
                        return "Enter name";
                    }else if (value!.length <=5) {
                         return "Letters must contain 5 characters";
                     }
                    },
                    decoration: InputDecoration(
                      disabledBorder: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(30)),
                      prefixIcon: const Icon(
                          Icons.alternate_email,
                          size: 25,
                          color: Colors.grey),
                      labelText: "Full name",
                      labelStyle:
                      const TextStyle(color: Colors.black),
                      hintText: "Enter full name",
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
                  TextFormField(
                    decoration: InputDecoration(
                      disabledBorder: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(30)),
                      prefixIcon: const Icon(
                          Icons.password_outlined,
                          size: 25,
                          color: Colors.grey),
                      labelText: "Enter email address",
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
                    validator: (value) { {
                      if (value!.isEmpty) {
                       return "Please enter email";
                      }
                            RegExp emailReg = RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}');
                              if (!emailReg.hasMatch(value)) {
                    return "Please provide valid email";
                      }
                    }
                  }),
                  SizedBox(height: Get.height * .03,),

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
                  SizedBox(height: Get.height * .035,),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30),
                    child: Stack(
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              _submitSignUpForm();
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
                              "Sign Up",
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
                              Get.to(const SignUpScreen());
                            },
                          ),
                        )
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
