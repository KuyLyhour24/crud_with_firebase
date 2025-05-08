import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/views/user.view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/user.model.dart';

class UserController extends GetxController{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
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
      await _auth.createUserWithEmailAndPassword(email: user.email, password: user.password);
      await _firestore.collection('users').add(user.toMap());
      Get.snackbar(
        "Success", "User added",
        backgroundColor: Colors.lightBlueAccent,
        colorText: Colors.black,
      );
    }on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
       Get.snackbar("Error", 'The password provided is too weak.',
         backgroundColor: Colors.lightBlueAccent,
         colorText: Colors.red,);
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('Error', 'The account already exists for that email.',
          backgroundColor: Colors.lightBlueAccent,
          colorText: Colors.red,
        );
      }
    }catch(e){
      Get.snackbar(
        "Error", "Failed to add user: $e",
        backgroundColor: Colors.lightBlueAccent,
        colorText: Colors.red,
      );
    }
  }
  Future<void> loginUser(String email, String password) async {
    try {
       await _auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
       Get.snackbar("Success", 'User login successfully');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
  Future<void> updateUser(UserModel user) async {
    try{
      await _firestore.collection('users').doc(user.id).update(user.toMap());
      Get.snackbar(
        "Success", "User updated",
        backgroundColor: Colors.lightBlueAccent,
        colorText: Colors.black,
      );
    }catch(e){
      Get.snackbar(
        "Error", "Failed to update user: $e",
        backgroundColor: Colors.lightBlueAccent,
        colorText: Colors.red,
      );
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      await _firestore.collection('users').doc(id).delete();
      Get.snackbar(
        "Success", "User deleted",
        backgroundColor: Colors.lightBlueAccent,
        colorText: Colors.black,
      );
    } catch (e) {
      Get.snackbar(
        "Error", "Failed to delete user: $e",
        backgroundColor: Colors.lightBlueAccent,
        colorText: Colors.red,
      );
    }
  }

}