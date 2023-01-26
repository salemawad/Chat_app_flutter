import 'package:chatapp/controller/loginController.dart';
import 'package:chatapp/view/componenet/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginController controller= Get.put(LoginController());
    return Scaffold(
      body: SafeArea(
          child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            margin: const EdgeInsets.only(top: 100, bottom: 50),
            child: const Text(
              textAlign: TextAlign.center,
              "Login",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextField(
            onChanged: (val) {
              controller.email=val;
            },
            decoration: const InputDecoration(
                hintText: "Enter your email",
                prefixIcon: Icon(Icons.email),
                label: Text("Email"),
                border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(5)))),
          ),
          const SizedBox(
            height: 15,
          ),
          TextField(
            onChanged: (val) {
              controller.password=val;
            },
            obscureText: true,
            decoration: const InputDecoration(
                hintText: "Enter your password",
                prefixIcon: Icon(Icons.lock),
                label: Text("Password"),
                border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(5)))),
          ),
          const SizedBox(
            height: 50,
          ),
          Material(
            color: AppColors.buttonColor,
            child: MaterialButton(
                onPressed: () async{
                  await controller.login();
                },
                child: const Text(
                  "Login",
                    style: TextStyle(color:AppColors.textButtonColor),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Cannot have to account",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                TextButton(
                    onPressed: () {
                      Get.offAndToNamed("/sign_up");
                    },
                    child: const Text(
                      "Sign up",
                      style: TextStyle(color: Colors.blue),
                    ))
              ],
            ),
          )
        ],
      )),
    );
  }
}
