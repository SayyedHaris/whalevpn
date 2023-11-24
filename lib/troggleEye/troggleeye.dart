import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TroggleEye extends GetxController {
  RxBool isVisible = false.obs;
  var selectedDate = DateTime.now().obs;

  RxInt currentInd = 0.obs;

  RxBool flag = true.obs;

  void flagSwitch(){
    flag.value = !flag.value;
  }

  void TroggleSwitch(){
    isVisible.value = !isVisible.value;
  }


   chooseDate () async{

    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
    }
  }

  currentIndex(int value){

    currentInd.value = value;

  }

}