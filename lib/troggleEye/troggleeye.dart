
    import 'package:get/get.dart';

class TroggleEye extends GetxController {
  RxBool isVisible = false.obs;



  void TroggleSwitch(){
    isVisible.value = !isVisible.value;
  }

}