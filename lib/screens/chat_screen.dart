import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:training/adapterers/message_addapter.dart';
import 'package:training/chat_bloc.dart';
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
                    if (channelMessageList.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(70.0),
                        child:
                            Lottie.asset("assets/animation/firstMessage.json"),
                      );
                    }
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
                textInputAction: TextInputAction.newline,
                // maxLines: 3,
                maxLines: 2,
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
                              "Me",
                              channelID,
                              chatID);
                          messageController.text = "";
                          // messageController.dispose();
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
            alignment: isBot ? Alignment.centerLeft : Alignment.centerRight,
            width: chatMessage.length > 30 ? 300 : null,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.blue[600],
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 4,
                right: 6,
                bottom: 4,
                left: 6,
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
