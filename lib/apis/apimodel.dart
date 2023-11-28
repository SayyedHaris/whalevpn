import 'dart:developer';
import 'dart:io';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:whale_vpn/pages/homepage.dart';

class Apis{

  static FirebaseAuth auth = FirebaseAuth.instance;

  static User get user => auth.currentUser!;


  handleGoogleButtonClick() {

    showDialog(
      context: Get.context!,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    signInWithGoogle().then((user) async {
      //for hiding progress bar
      // Get.back();
      Get.to(HomePage());
    });
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');

      // Sign in process which shows multiple accounts
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      // Obtain auth details by request
      final GoogleSignInAuthentication? gAuth = await gUser?.authentication;

      // New credential user
      final credential = GoogleAuthProvider.credential(
          accessToken: gAuth?.accessToken, idToken: gAuth?.idToken);

      // Finally sign in
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      log('\n_signInWithGoogle: $e');
      Get.back();
      //
      // Get.snackbar(
      //   'Something went wrong',
      //   'Check Internet Connection!',
      // );
      // Get.snackbar('Something went wrong', 'Check Internet Connection!',
      //     snackPosition: SnackPosition.BOTTOM,
      //     backgroundColor: Colors.black,
      //     colorText: Colors.grey);

    }
  }

  disconnectWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.disconnect();
    await FirebaseAuth.instance.signOut();
  }

}