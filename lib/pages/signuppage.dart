import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whale_vpn/screens/widgetscreen.dart';
import 'package:whale_vpn/troggleEye/troggleeye.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      signUserUp();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Account Created Successfully")));
      // Get.to(const SignUpScreen());
    }  else{
      Get.snackbar("Sorry", "Fill the form properly");
    }
  }


  final TextEditingController _fullNamecontroller = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  

  void signUserUp() async {
    showDialog(context: context, builder: (context) {
      return const Center(child: CircularProgressIndicator(),);
    },);

    try{

     await FirebaseAuth.instance.createUserWithEmailAndPassword(email:_emailController.text, password: _passController.text);

     addUserDetails(
       _fullNamecontroller.text,
       _emailController.text,
         _passController.text
     );

     Navigator.pop(context);

    }

    on FirebaseAuthException catch(e){

      Navigator.pop(context);

      print(e);
    }
  }
  Future addUserDetails(String fullname, String email, String password) async {
  await FirebaseFirestore.instance.collection("users").add({
    'Full Name' : fullname,
    'Email' : email,
    "Password" : password
  });
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
                    },controller: _fullNamecontroller,
                    decoration: InputDecoration(
                      disabledBorder: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(30)),
                      prefixIcon: const Icon(
                          Icons.person,
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
                    controller: _emailController,
                    decoration: InputDecoration(
                      disabledBorder: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(30)),
                      prefixIcon: const Icon(
                          Icons.alternate_email,
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
                      controller: _passController,
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
