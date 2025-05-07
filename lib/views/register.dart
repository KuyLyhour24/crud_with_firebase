import 'package:crud_firebase/views/login.dart';
import 'package:crud_firebase/widgets/button.dart';
import 'package:crud_firebase/widgets/passwordTextfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/email.controller.dart';
import '../controllers/password.controller.dart';
import '../controllers/user.controller.dart';
import '../models/user.model.dart';
import '../widgets/textfield.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});
  final UserController userController = Get.put(UserController());
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailValidator = Get.put(EmailFieldController());
  final passwordVisible = Get.put(PasswordVisibilityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600,color: Colors.lightBlue),),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
        backgroundColor: Colors.white,
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Sign Up",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 30,
                  color: Colors.lightBlue
                ),
              ),
              SizedBox(height: 20,),
              Text("Enter your credentials to continue",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 30,),
              CustomTextField( label: "Enter your username",controller: nameController,),
              SizedBox(height: 20,),
              CustomTextField( label: "Enter your email",controller: emailController,isEmail: true,emailFieldController: emailValidator,),
              SizedBox(height: 20,),
              PasswordTextfield(label: "Enter your password",isPassword: true,controller: passwordController,),
              SizedBox(height: 20,),
              CustomTextField(label: "Enter your age",controller: ageController,),
              SizedBox(height: 40,),

              CustomButton(text: "Register", onTap: (){
                final user = UserModel(
                  name: nameController.text.trim(),
                  age: int.tryParse(ageController.text) ?? 0,
                  email: emailController.text.trim(),
                  password: passwordController.text,
                  created_date: DateTime.now().toIso8601String(),
                  updated_date: DateTime.now().toIso8601String(),
                );
                userController.addUser(user);
                emailController.clear();
                passwordController.clear();
                nameController.clear();
                ageController.clear();
              }),
              SizedBox(height: 20,),
              CustomButton(text: "Login", onTap: ()=>Get.to(LoginView()))
            ],
          ),
        ),
      )
    );
  }
}
