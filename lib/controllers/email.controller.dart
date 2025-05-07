import 'package:get/get.dart';

class EmailFieldController extends GetxController {
  var isValid = false.obs;

  void validate(String value) {
    isValid.value = GetUtils.isEmail(value.trim());
  }
}
