import 'package:chatapp/view/screens/home.dart';
import 'package:chatapp/view/screens/login.dart';
import 'package:chatapp/view/screens/signup.dart';
import 'package:chatapp/view/screens/splash.dart';
import 'package:chatapp/view/screens/test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
bool? isLogin ;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());

  var user = FirebaseAuth.instance.currentUser!;
  if(user!=null){
    isLogin = true;
  }else{
    isLogin=false;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {

  return GetMaterialApp(

      debugShowCheckedModeBanner: false,
       getPages: [
        GetPage(name: '/', page: () =>   Splash()),
        GetPage(name: '/Login', page: () => isLogin ==true?UsersShow(): Login()),
        GetPage(name: '/sign_up', page: () => const SignUp()),
        GetPage(name: '/all_user', page: () => const UsersShow()),
        GetPage(name: '/home', page: () => const Home()),

      ],
    );
  }
}

