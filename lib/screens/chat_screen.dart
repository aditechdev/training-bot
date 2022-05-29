import 'dart:ffi';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:training/adapterers/message_addapter.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String selectedLanguage = " ";
  String selectedTitle = " ";
  TextEditingController messageController = TextEditingController();
  String image = " ";
  @override
  void initState() {
    // Map a = ModalRoute.of(ctxt).settings.arguments as Map;
    // if (a != null) {
    //   clickedIndex = a["clickedIndex"];
    //   if (mounted && clickedIndex != null) {
    //     Future.delayed(const Duration(milliseconds: 100), () {
    //       itemscrollController.jumpTo(index: clickedIndex, alignment: 0);
    //     });
    //   }
    // }

    // });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    Map a = ModalRoute.of(context)!.settings.arguments as Map;
    // Future.delayed(const Duration(milliseconds: 1000), () async{
    // setState(() {
    selectedLanguage = a["learningLanguage"];
    selectedTitle = a["topic"];
    image = a["image"];
    // });

    super.didChangeDependencies();
  }

  void printMessage() {
    print("okkk");
  }

  sendMessage() {
    Map<String, dynamic> messageMap = {
      "message": messageController.text,
      "date": DateTime.now().toIso8601String(),
      "userName": "Aditya",
      "isBot": false,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(selectedTitle),
        ),
        body: Container(
          child: Stack(
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                child: TextFormField(
                  // style: Style.chatTextStyle
                  // .copyWith(color: Theme.activeTextColor, fontSize: 14),
                  controller: messageController,
                  // onFieldSubmitted: (String text) => onSubmit(),

                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Type Here",
                    fillColor: Colors.black38,
                    filled: true,
                    suffixIcon: InkWell(
                        onTap: () {
                        
                          Box<MessageModel> messageBox =
                              Hive.box<MessageModel>("messageModel");
                          // messageBox.add(MessageModel(selectedTitle,
                          //     ChattMessage(false,), "ok", selectedLanguage, image));
                          // messageBox.add(MessageModel(topic: selectedTitle , chatMessage: , color: "okoko", language:selectedLanguage , image:image ));
                          // // todoBox.add(
                          //     MessageModel(title: title, discription: description));
                        },
                        child: Icon(Icons.send, color: Colors.white)),
                    // Icon(Icons.send, color: Colors.white),

                    // hintStyle: Style.chatTextStyle.copyWith(fontSize: 12)),
                  ),
                ),
              )
            ],
          ),
        )
        // Column(
        //   children: [
        //     Expanded(
        //       child: SizedBox(
        //         child: SingleChildScrollView(
        //           dragStartBehavior: DragStartBehavior.down,
        //           child: Column(
        //             children: const [
        //               NewWidget(),
        //               NewWidget(),
        //               NewWidget(),
        //               NewWidget(),
        //               NewWidget(),
        //               NewWidget(),
        //               NewWidget(),
        //               NewWidget(),
        //               NewWidget(),
        //               NewWidget(),
        //               NewWidget(
        //                 text: "OK",
        //               ),
        //               SizedBox(
        //                 height: 50,
        //               )
        //             ],
        //           ),
        //         ),
        //       ),
        //     ),
        //     TextFormField(
        //       // style: Style.chatTextStyle
        //       // .copyWith(color: Theme.activeTextColor, fontSize: 14),
        //       // controller: _textController,
        //       // onFieldSubmitted: (String text) => onSubmit(),
        //       decoration: const InputDecoration(
        //         border: InputBorder.none,
        //         hintText: "Type Here",
        //         // hintStyle: Style.chatTextStyle.copyWith(fontSize: 12)),
        //       ),
        //     ),
        //     // Text("data"),
        //     // Scaffold(
        //     //   bottomNavigationBar:
        //     // )
        //   ],
        // ),
        );
  }
}

class NewWidget extends StatelessWidget {
  final String text;
  const NewWidget({
    Key? key,
    this.text = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      (text == "") ? "data" : text,
      style: TextStyle(
        fontSize: 50,
      ),
    );
  }
}
