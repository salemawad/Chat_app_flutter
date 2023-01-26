import 'package:chatapp/view/componenet/colors.dart';
import 'package:chatapp/view/screens/home.dart';
import 'package:chatapp/view/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// var user = FirebaseAuth.instance.currentUser!;

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Future.delayed(const Duration(seconds: 3),() => Get.offNamed("/Login"));
    return Scaffold(
      backgroundColor: Colors.yellow[300],
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                    top: 150, bottom: 50, left: 100, right: 100),
                height: 200,
                width: 200,
                child: Image.asset("images/chat.png"),
              ),
              const Text(
                "Welcome to Message me",
                style: TextStyle(
                    color: AppColors.buttonColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              MaterialButton(onPressed: (){
                Get.toNamed("/Login");
              },child: Text("Goo"),)
            ],
        ),
      ),
          ),
    );
  }
}
