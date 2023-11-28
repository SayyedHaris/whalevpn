import 'dart:async';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whale_vpn/imagepicker/imagepicker.dart';
import 'package:whale_vpn/pages/loginpage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {





      @override
  void initState() {
    // TODO: implement initState
    super.initState();
      islogin();
  }

      String? name = '';


      void islogin() async{
        var prefs = await SharedPreferences.getInstance();
          name = prefs.getString("String");
        setState(() {

        });
      }

  final ImagePickerController _pickerController =
      Get.put(ImagePickerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Profile Screen"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: Get.height * .06,
            ),
            Obx(
              () => Stack(
                children: [
                  Center(
                    child: CircleAvatar(
                      backgroundImage: _pickerController.imagePath.isNotEmpty
                          ? FileImage(
                              File(_pickerController.imagePath.toString()))
                          : null,
                      radius: 130,
                    ),
                  ),
                  Positioned(
                    right: 95,
                    top: 30,
                    child: CircleAvatar(
                      backgroundColor: Colors.cyan,
                      child: IconButton(
                        onPressed: () async {
                          Get.defaultDialog(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 35),
                              content: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                      onPressed: () async {
                                        if (await Permission.camera
                                            .request()
                                            .isGranted) {
                                          // _getFromGallery(context);
                                          _pickerController
                                              .getImagefromCamera();
                                          Get.back();
                                          print("Camera Permission is granted");
                                        } else {
                                          await Permission.camera.request();
                                          print("Camera Permission is denied.");
                                        }
                                      },
                                      tooltip: "Camera",
                                      icon: const Icon(
                                        Icons.camera,
                                        size: 50,
                                      )),
                                  IconButton(
                                      onPressed: () async {
                                        PermissionStatus galleryPermission =
                                            await Permission.photos.request();

                                        if (galleryPermission ==
                                            PermissionStatus.granted) {
                                          // _getFromPhotos(context);
                                          _pickerController
                                              .getImagefromgallary();
                                          Get.back();
                                        }
                                        if (galleryPermission ==
                                            PermissionStatus.denied) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content:
                                                      Text("Please Allow")));
                                        }
                                        if (galleryPermission ==
                                            PermissionStatus
                                                .permanentlyDenied) {
                                          openAppSettings();
                                        }
                                      },
                                      tooltip: "gallery",
                                      icon: const Icon(
                                        Icons.image,
                                        size: 50,
                                      )),
                                ],
                              ),
                              title: "Choose");
                        },
                        icon: const Icon(Icons.add, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(name.toString()),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              var prefs = await SharedPreferences.getInstance();
               prefs.setString("String", "This is Shared Preference Text");



              print(prefs.get("String"));
              setState(() {

              });

            },
            child: const Icon(Icons.add)));
  }
}

// _getFromGallery(context) async {
//
//   try {
//     XFile? pickedFile = await ImagePicker().pickImage(
//       source: ImageSource.camera,
//       maxWidth: 1800,
//       maxHeight: 1800,
//     );
//     if (pickedFile != null) {
//       File imageFile = File(pickedFile.path);
//     }
//   } catch (e) {
//     print(e.toString());
//   }
// }
//
_getFromPhotos(context) async {
  try {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      return imageFile;
    }
  } catch (e) {
    print(e.toString());
  }
}
