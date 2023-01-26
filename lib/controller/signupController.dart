import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController{

  var email , password , username;
   var store = FirebaseFirestore.instance;
   var auth = FirebaseAuth.instance;

  newUser () async{

    try {
      Get.defaultDialog(title: "wait...",content: const Center(child: CircularProgressIndicator()));
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      await store.collection("users").doc(auth.currentUser!.uid).set({
        "username":username,
        "email":email,
        "state":"online",
        "uid":auth.currentUser!.uid
      });
      Get.toNamed("/Login");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }


}