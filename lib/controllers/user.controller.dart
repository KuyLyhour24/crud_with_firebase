import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/user.model.dart';

class UserController extends GetxController{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var users = <UserModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  void fetchUsers() {
    _firestore.collection('users').snapshots().listen((snapshot) {
      users.value = snapshot.docs
          .map((doc) => UserModel.fromMap(doc.id, doc.data()))
          .toList();
    });
  }
  Future<void> addUser(UserModel user) async {
    try{
      await _firestore.collection('users').add(user.toMap());
      Get.snackbar(
        "Success", "User added",
        backgroundColor: Colors.white38,
        colorText: Colors.blue,
        snackPosition: SnackPosition.BOTTOM);
    }catch(e){
      Get.snackbar(
        "Error", "Failed to add user: $e",
        backgroundColor: Colors.white38,
        colorText: Colors.blue,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> updateUser(UserModel user) async {
    try{
      await _firestore.collection('users').doc(user.id).update(user.toMap());
      Get.snackbar(
        "Success", "User updated",
        backgroundColor: Colors.white38,
        colorText: Colors.blue,
          snackPosition: SnackPosition.BOTTOM
      );
    }catch(e){
      Get.snackbar(
        "Error", "Failed to update user: $e",
        backgroundColor: Colors.white38,
        colorText: Colors.blue,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      await _firestore.collection('users').doc(id).delete();
      Get.snackbar(
        "Success", "User deleted",
        backgroundColor: Colors.white38,
        colorText: Colors.blue,
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar(
        "Error", "Failed to delete user: $e",
        backgroundColor: Colors.white38,
        colorText: Colors.blue,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

}