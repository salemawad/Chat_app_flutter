import 'package:chatapp/controller/homeController.dart';
import 'package:chatapp/view/componenet/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

var auth = FirebaseAuth.instance;
var store = FirebaseFirestore.instance;
var userLogin = auth.currentUser!.email;

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    var textController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () async{
         await controller.signOut();
        }, icon: Icon(Icons.close))],
        toolbarHeight: 70,
        backgroundColor: AppColors.textButtonColor,
        title: const StreamBar()
      ),
      body: SafeArea(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: controller.store.collection("message").orderBy("time").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.active) {
                    List<MessageLine> messageWidget = [];
                    final allMessage = snapshot.data!.docs.reversed;
                    for (var message in allMessage) {
                      final textMessage = message.get("text");
                      final senderMessage = message.get("email");
                      final messagAll =
                          MessageLine(sender: senderMessage, text: textMessage);
                      messageWidget.add(messagAll);
                    }
                    return Expanded(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                        reverse: true,
                        children: messageWidget,
                      ),
                    );
                  } else {
                    return const Center(
                        child: CircularProgressIndicator());
                  }
                },
              ),
              //sending message ...
              Container(
                decoration: const BoxDecoration(
                    border: Border(top: BorderSide(width: 1))),
                child: TextField(
                  controller: textController,
                    onChanged: (val) {
                      controller.textMessage = val;
                    },
                    decoration: InputDecoration(
                        hintText: "enter your message ...",
                        suffixIcon: IconButton(
                            onPressed: () async {
                              textController.clear();
                              await controller.uploadMessage();
                            },
                            icon: const Icon(
                              Icons.send,
                              color: AppColors.textButtonColor,
                            )),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(width: 1)))),
              )
            ]),
      ),
    );
  }
}

class StreamBar extends StatelessWidget {
  const StreamBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  StreamBuilder(
        stream: store.collection("users").where("uid",isNotEqualTo: auth.currentUser!.uid).snapshots(),
        builder: (context,snapshot){
          if(snapshot.hasData && snapshot.connectionState==ConnectionState.active){
            return Column(
              children: [
                Text("${snapshot.data!.docs[0]['username']}",style: const TextStyle(fontSize: 18),),
                const SizedBox(height: 5,),
                Text("${snapshot.data!.docs[0]['state']}",style: const TextStyle(fontSize: 15),),
              ],);
          }
          return Text("data");
        });
  }
}

class MessageLine extends StatelessWidget {
  const MessageLine({Key? key, this.sender, this.text}) : super(key: key);

  final String? sender;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: sender == userLogin
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Text("$sender"),
          const SizedBox(height: 4,),
          Material(
            color: sender == userLogin ? Colors.blue[800] : Colors.yellow[800],
            elevation: 5,
            borderRadius: sender == userLogin
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "$text",
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class MessageLine extends StatelessWidget {
//   const MessageLine({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         shrinkWrap: true,
//         padding: EdgeInsets.all(3),
//         itemCount: snapshot.data!.docs.length,
//         itemBuilder: (context, i) {
//
//
//           var senderEmail = snapshot.data!.docs[i]['email'];
//           var userLogin = controller.auth.currentUser!.email;
//           var messageText = snapshot.data!.docs[i]['text'];
//
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: [
//                 Text("$senderEmail"),
//                 Material(
//                   color: senderEmail==userLogin? Colors.blue[800]:Colors.yellow[800],
//                   elevation: 5,
//                   borderRadius:  senderEmail==userLogin? const BorderRadius.only(
//                     topLeft: Radius.circular(30),
//                     bottomLeft: Radius.circular(30),
//                     bottomRight: Radius.circular(30),
//                   ):const BorderRadius.only(
//                     topRight: Radius.circular(30),
//                     bottomLeft: Radius.circular(30),
//                     bottomRight: Radius.circular(30),
//                   ),
//                   child: Padding(
//                     padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                     child: Text(
//                       "$messageText",
//                       style: const TextStyle(color: Colors.white,fontSize: 15),
//                     ),
//                   ),
//                 ),
//
//               ],
//             ),
//           );
//         });;
//   }
// }
