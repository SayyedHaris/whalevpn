import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:whale_vpn/pages/otpverifypage.dart';

class VerificationPage extends StatefulWidget {
  final String VerificationId;
  const VerificationPage({Key? key, required this.VerificationId})
      : super(key: key);

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final phoneNumberController = TextEditingController();
  final countryCodeController = TextEditingController();
  final verifyCodeController = TextEditingController();

  final auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  late int _countdownSeconds;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _countdownSeconds = 0;
  }

  void startCountdownTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdownSeconds >= 60) {
          _countdownSeconds--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: Get.height * .1, horizontal: Get.width * .1),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * .02,
                ),
                const Text(
                  "Verification",
                  style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Code",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.deepOrange.shade200,
                  ),
                  height: 8,
                  width: 60,
                ),
                SizedBox(
                  height: Get.height * .08,
                ),
                Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        SizedBox(
                          height: Get.height * .03,
                        ),
                        IntlPhoneField(
                          //disableLengthCheck: true,
                          controller: phoneNumberController,
                          initialCountryCode: 'IN',
                          decoration: const InputDecoration(
                              hintText: 'Enter Phone Number',
                              hintStyle: TextStyle(fontSize: 15),
                              labelText: 'Phone Number',
                              border: OutlineInputBorder()),
                          validator: (value) {
                            if (value!.completeNumber.isEmpty) {
                              return "Enter valid phone number";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            countryCodeController.text = value.countryCode;
                          },
                        ),
                        SizedBox(
                          height: Get.height * .03,
                        ),
                        Pinput(

                          onChanged: (value) {

                            debugPrint('onChanged: $value');
                          },
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return 'Enter valid verification code';
                          //   }
                          //   return null;
                          // },
                          controller: verifyCodeController,
                          separatorBuilder: (index) =>
                              const SizedBox(width: 30),
                          cursor: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 9),
                                width: 22,
                                height: 1,
                                color: Colors.black,
                              ),
                            ],
                          ),
                          length: 4,
                          useNativeKeyboard: true,
                          hapticFeedbackType: HapticFeedbackType.lightImpact,

                          // textInputAction: TextInputAction.next,
                        ),
                        SizedBox(
                          height: Get.height * .08,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Resend code in  ",
                              style: TextStyle(fontSize: 18),
                            ),
                            CountdownTimer(
                              endTime: DateTime.now().millisecondsSinceEpoch +
                                  _countdownSeconds * 1000,
                              textStyle: TextStyle(
                                  color: Colors.grey.shade600, fontSize: 17),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * .08,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                minimumSize: Size(Get.width, Get.height * .08),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            onPressed: () async {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              );
                              final credential = PhoneAuthProvider.credential(
                                  verificationId: widget
                                      .VerificationId, // this is from back screen
                                  smsCode:
                                      verifyCodeController.text.toString());

                              try {
                                await auth.signInWithCredential(credential);
                                print('Harris Sayyed');
                                // Navigator.pop(context);
                                Get.to(const OtpVerifyPage());
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => const HomeScreen(),
                                //     ));
                              } catch (e) {
                                // ignore: use_build_context_synchronously
                                print("This is the problem");
                                print(e);
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(e.toString()),
                                    );
                                  },
                                );
                              }
                            },
                            child: const Text(
                              "Verify",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )),
                        SizedBox(
                          height: Get.height * .03,
                        ),
                        Stack(
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    minimumSize:
                                        Size(Get.width, Get.height * .08),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30))),
                                onPressed: () async {
                                  setState(() {
                                    _countdownSeconds = 60;
                                    startCountdownTimer();
                                  });
                                  if (_formKey.currentState!.validate()) {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },
                                    );
                                    final phoneNumber =
                                        countryCodeController.text +
                                            phoneNumberController.text;

                                    try {
                                      await auth.verifyPhoneNumber(
                                          phoneNumber: phoneNumber,
                                          timeout: const Duration(seconds: 60),
                                          verificationCompleted: (_) {
                                            Get.back(); // Dismiss loading dialog
                                            // Navigator.pop(context); // Dismiss loading dialog
                                            // showDialog(
                                            //   context: context,
                                            //   builder: (context) {
                                            //     return const Center(
                                            //       child: CircularProgressIndicator(),
                                            //     );
                                            //   },
                                            // );
                                          },
                                          verificationFailed: (e) {
                                            Get.back(); // Dismiss loading dialog
                                            // Navigator.pop(context); // Dismiss loading dialog
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                    title: Text(e.toString()));
                                              },
                                            );
                                          },
                                          codeSent: (String verificationId,
                                              int? token) {
                                            Get.back(); // Dismiss loading dialog
                                            // Navigator.pop(context); // Dismiss loading dialog
                                            Get.to(VerificationPage(
                                              VerificationId: verificationId,
                                            ));
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //       builder: (context) => VerifyCodeScreen(
                                            //           verificationId: verificationId),
                                            //     ));
                                          },
                                          codeAutoRetrievalTimeout: (e) {
                                            //Navigator.pop(context); // Dismiss loading dialog
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                    title: Text(e.toString()));
                                              },
                                            );
                                          });
                                    } catch (e) {
                                      //Navigator.pop(context); // Dismiss loading dialog
                                      // ignore: use_build_context_synchronously
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                              title: Text(e.toString()));
                                        },
                                      );
                                    }
                                  }
                                },
                                child: const Text(
                                  "Send Code",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )),
                            Positioned(
                              right: 20,
                              bottom: 15,
                              child: MaterialButton(
                                shape: const StadiumBorder(),
                                minWidth: 20,
                                height: Get.height * .05,
                                color: Colors.white70,
                                child: const Icon(Icons.arrow_forward),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
