import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/email.controller.dart';


class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool isPassword;
  final bool isEmail;
  final EmailFieldController? emailFieldController;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.isPassword = false,
    this.isEmail = false,
    this.emailFieldController,

  });

  @override
  Widget build(BuildContext context) {
    Widget suffixIcon = const SizedBox.shrink();
    if (isEmail && emailFieldController != null) {
      suffixIcon = Obx(()=>emailFieldController!.isValid.value
          ? const Icon(Icons.check_circle, color: Colors.lightBlue)
          : const SizedBox.shrink());
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: TextField(
            controller: controller,
            onChanged: (val) {
              if (isEmail && emailFieldController != null) {
                emailFieldController!.validate(val);
              }
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: label,
              labelStyle: TextStyle(fontSize: 20),
              suffixIcon: suffixIcon, // Show the appropriate icon
            ),
          ),
        ),
      ],
    );
  }
}
