import 'package:chatapp/view/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{

  var email,password;
var store = FirebaseFirestore.instance;
var auth = FirebaseAuth.instance;
  login()async{
  try {
    Get.defaultDialog(title: "wait...",content: const Center(child: CircularProgressIndicator()));
  UserCredential userCredential = await auth.signInWithEmailAndPassword(
  email: email,
  password: password
  );
 await store.collection("users").doc(auth.currentUser!.uid).update({
    "state":"online"
  });
  Get.toNamed("all_user");
  } on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
  print('No user found for that email.');
  } else if (e.code == 'wrong-password') {
  print('Wrong password provided for that user.');
  }
  }
  }
}