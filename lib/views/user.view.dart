import 'package:crud_firebase/views/register.dart';
import 'package:crud_firebase/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/user.controller.dart';
import '../models/user.model.dart';

class UserView extends StatelessWidget {
  UserView({super.key});
  final UserController userController = Get.put(UserController());
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("User",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700),),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Obx(() => ListView.builder(
              itemCount: userController.users.length,
              itemBuilder: (_, index) {
                final user = userController.users[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 10,left: 10,right: 10),
                  width: double.infinity,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey.shade100, // Border color
                      width: 1.0,         // Border width
                    ),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.person,size: 30,color: Colors.lightBlue,),
                    title: Text(user.name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                    subtitle: Text(user.email,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit,size: 30,color: Colors.lightBlue),
                            onPressed: () {
                              nameController.text = user.name;
                              ageController.text = user.age.toString();
                              emailController.text = user.email;
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  shadowColor: Colors.blueGrey,
                                  backgroundColor: Colors.white,

                                  insetPadding: EdgeInsets.zero,
                                  title: Container(
                                    padding: EdgeInsets.all(10),
                                      width: 400,
                                      child: Text("Update User",style: TextStyle(fontSize: 30),)),
                                  content: Container(
                                    padding: EdgeInsets.all(10),
                                    width: 400,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CustomTextField(controller: nameController, label: 'Update name'),
                                        CustomTextField(controller: emailController, label: 'Update email'),
                                        CustomTextField(controller: ageController, label: 'Update age'),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      child: Text("Cancel",style: TextStyle(fontSize: 20,color: Colors.lightBlue),),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        final updatedUser = UserModel(
                                          id: user.id,
                                          name: nameController.text,
                                          age: int.tryParse(ageController.text) ?? 0,
                                          email: emailController.text,
                                          password: user.password,
                                          created_date: user.created_date,
                                          updated_date: DateTime.now().toIso8601String(),
                                        );
                                        userController.updateUser(updatedUser);
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Update",style: TextStyle(fontSize: 20,color: Colors.lightBlue),),
                                    ),
                                  ],
                                ),
                              );
                            }
                        ),
                        IconButton(
                          icon: Icon(Icons.delete,size: 30,color: Colors.redAccent,),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                shadowColor: Colors.blueGrey,
                                backgroundColor: Colors.white,
                                insetPadding: EdgeInsets.zero,
                                title: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text("Delete User",style: TextStyle(fontSize: 20),)),
                                content: Text("Are you sure you want to delete?"),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () => Navigator.of(context).pop(),
                                    child: Text("Cancel",style: TextStyle(fontSize: 20,color: Colors.lightBlue),),
                                  ),
                                  TextButton(onPressed: () => userController.deleteUser(user.id!),
                                    child: Text("Confirm",style: TextStyle(fontSize: 20,color: Colors.lightBlue),),)
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            )),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Get.to(RegisterView()),
          backgroundColor: Colors.lightBlue,
        child: Icon(Icons.add),
      ),
    );
  }
}
