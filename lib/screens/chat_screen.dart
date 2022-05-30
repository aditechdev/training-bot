import 'dart:ffi';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:training/adapterers/message_addapter.dart';
import 'package:training/chat_bloc.dart';
import 'package:training/main.dart';
import 'package:uuid/uuid.dart';

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
  String channelID = " ";
  bool createChannel = false;
  var uuid = const Uuid();
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
    selectedLanguage = a["learningLanguage"];
    selectedTitle = a["topic"];
    image = a["image"];
    channelID = a["channelID"];
    createChannel = a["fromCreaterScreen"];

    super.didChangeDependencies();
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
        body: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: StreamBuilder<List<ChatMessageModel>>(
                  stream: chatBloc.getChats,
                  builder: (context, snapshot) {
                    List<ChatMessageModel> channelMessageList = chatBloc
                        .fetchCurrentChannelMessages(channelID)
                        .toList();
                    return ListView.builder(
                        reverse: true,
                        itemCount: channelMessageList.length,
                        itemBuilder: (BuildContext context, index) {
                          final chatMessageData = channelMessageList[index];
                          return ChatBubble(
                            chatMessage: chatMessageData.message,
                            isBot: chatMessageData.isBot,
                            createdAt: chatMessageData.getDate(),
                          );
                        });
                  }),
            ),
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
                        if (messageController.text.isNotEmpty) {
                          var chatID = uuid.v1();
                          if (createChannel) {
                            //  Create Channel
                            chatBloc.createChannel(selectedTitle, channelID,
                                selectedLanguage, image);
                          }

                          // Create Message box
                          chatBloc.createChat(
                              false,
                              messageController.text,
                              DateTime.now().millisecondsSinceEpoch.toString(),
                              "Aditya Anand",
                              channelID,
                              chatID);
                        }
                      },
                      child: const Icon(Icons.send, color: Colors.white)),
                ),
              ),
            )
          ],
        ));
  }
}

class ChatBubble extends StatelessWidget {
  final String chatMessage;
  final bool isBot;
  final String createdAt;
  const ChatBubble({
    Key? key,
    required this.chatMessage,
    this.isBot = false,
    required this.createdAt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 16,
        left: 16,
        right: 16,
      ),
      child: Row(
        mainAxisAlignment:
            isBot ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          Container(
            color: Colors.blue[600],
            alignment: isBot ? Alignment.centerLeft : Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 16,
                right: 16,
                bottom: 16,
                left: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    chatMessage,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    createdAt,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
