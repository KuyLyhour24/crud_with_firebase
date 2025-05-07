import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/email.controller.dart';
import '../controllers/password.controller.dart';


class PasswordTextfield extends StatelessWidget {
  final TextEditingController controller;
  final bool isPassword;
  final String label;
  PasswordTextfield({
    super.key,
    required this.controller,
    required this.label,
    this.isPassword = false,

  });
  final PasswordVisibilityController passwordController = Get.put(PasswordVisibilityController());
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Obx(() {
            return TextField(
              controller: controller,
              obscureText: !passwordController.isVisible.value,
              decoration: InputDecoration(
                labelText: label,
                labelStyle: TextStyle(fontSize: 20),
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    color: Colors.lightBlue,
                    passwordController.isVisible.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: passwordController.toggle,
                ),
              ),
            );
          }),

        ),
      ],
    );
  }
}
