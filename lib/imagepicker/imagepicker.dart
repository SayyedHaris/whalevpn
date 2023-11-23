import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends GetxController {
  RxString imagePath = ''.obs;

  final ImagePicker _picker = ImagePicker();

  Future getImagefromgallary() async {

    final image = await _picker.pickImage(source: ImageSource.gallery);
    // final image2 = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      imagePath.value = image.path.toString();
      // imagePath.value = image2!.path.toString();
    }
  }

  Future getImagefromCamera() async {


    final image2 = await _picker.pickImage(source: ImageSource.camera);
    if (image2 != null) {
      imagePath.value = image2.path.toString();
    }
  }
}