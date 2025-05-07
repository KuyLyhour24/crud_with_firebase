import 'package:crud_firebase/views/register.dart';
import 'package:crud_firebase/widgets/passwordTextfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/user.controller.dart';
import '../widgets/button.dart';
import '../widgets/textfield.dart';
class LoginView extends StatelessWidget {
  LoginView({super.key});
  final UserController userController = Get.put(UserController());
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Login",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60,),
            Text("Login",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 20,),
            Text("Enter your emails and password",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 30,),
            CustomTextField(label: "Enter your email",controller: emailController,isEmail: true,),
            SizedBox(height: 20,),
            PasswordTextfield(label: "Enter your password",isPassword: true,controller: passwordController,),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: (){},child: Text("Forgot password?",style: TextStyle(
                    fontSize: 16, color: Colors.black87
                ),),
                )],
            ),
            SizedBox(height: 20,),
            CustomButton(text: "Log In", onTap: (){}),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have account?", style: TextStyle(
                    fontSize: 16, color: Colors.black87
                ),),
                TextButton(onPressed: ()=>Get.to(RegisterView()),
                    child: Text("Sign Up", style: TextStyle(
                        fontSize: 16, color: Colors.lightBlue
                    ),)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
