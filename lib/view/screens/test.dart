import 'package:chatapp/view/componenet/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersShow extends StatefulWidget {
  const UsersShow({Key? key}) : super(key: key);

  @override
  State<UsersShow> createState() => _UsersShowState();
}

class _UsersShowState extends State<UsersShow> {
  var firestore = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder(
            future: firestore
                .collection("users")
                .where("uid", isNotEqualTo: auth.currentUser!.uid)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                return  ListTile(
                  tileColor: AppColors.textButtonColor,
                  leading: const Icon(Icons.person_pin),
                    title: Text("${snapshot.data!.docs[index]['username']}"),
                    subtitle: Text("${snapshot.data!.docs[index]['email']}"),
                  onTap: (){
                    Get.offNamed("/home");
                  },
                  );
                },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
