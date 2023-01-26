
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with WidgetsBindingObserver {
  var textMessage;

  late TextEditingController? textC;
  var store = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;

  uploadMessage() async {
    if (textMessage == null) {
      Get.defaultDialog(
          title: "please enter your message...",
          content: const Text("please enter your message..."),
          onConfirm:(){
            Get.back();
          }
      );
    }
    await store.collection("message").add({
      "text": textMessage,
      "email": auth.currentUser!.email,
      "time": FieldValue.serverTimestamp(),
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      updateUser("online");
    } else {
      updateUser("offline");
    }
  }

  updateUser(status) async {
    await store
        .collection("users")
        .doc(auth.currentUser!.uid)
        .update({"state": status});
  }

  signOut() async {
    await store
        .collection("users")
        .doc(auth.currentUser!.uid)
        .update({"state": "offline"});
    await auth.signOut();
    Get.toNamed("/Login");
  }

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);

    textC = TextEditingController();
    super.onInit();
  }
}
