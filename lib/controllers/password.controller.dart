// controllers/password_visibility_controller.dart
import 'package:get/get.dart';

class PasswordVisibilityController extends GetxController {
  var isVisible = false.obs;

  void toggle() => isVisible.value = !isVisible.value;
}
