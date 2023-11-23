import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({Key? key}) : super(key: key);

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: Get.height * .1, horizontal: Get.width * .1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Get.height * .02,),
            const Text(
              "Verification",
              style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Code",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
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
                  const Text(
                    "Verification Code was sent to",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: Get.height * .03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: Get.width * .06,),
                      const Text(
                        "+91 7744889942  ",
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                      ),
                      IconButton(onPressed: () {

                      }, icon: const Icon(CupertinoIcons.pen,color: Colors.grey,)),

                    ],
                  ),
                  SizedBox(
                    height: Get.height * .04,
                  ),
                  Pinput(
                    separatorBuilder: (index) => const SizedBox(width: 30),
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
                  SizedBox(height: Get.height * .08,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Resend code in  ",style: TextStyle(fontSize: 18),),
                      Text("00:16",style: TextStyle(color: Colors.grey.shade600, fontSize: 17),)
                    ],
                  ),

                  SizedBox(height: Get.height * .08,),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white,

                          minimumSize: Size(Get.width, Get.height * .08),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                      onPressed: () {

                  }, child: const Text("Resend",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),)),
                  SizedBox(height: Get.height * .03,),
                  Stack(
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(

                              minimumSize: Size(Get.width, Get.height * .08),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                          onPressed: () {

                          }, child: const Text("Send Code",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),)),

                      Positioned(
                        right: 20,
                        bottom: 15,
                        child: MaterialButton(
                          shape: const StadiumBorder(
                         ),

                          minWidth: 20,
                          height: Get.height * .05,

                          color: Colors.white70,
                          child: const Icon(Icons.arrow_forward),
                          onPressed: () {
                          },),
                      ),
                    ],
                  ),

                ],

              )
            ),
          ],
        ),
      ),
    );
  }
}
