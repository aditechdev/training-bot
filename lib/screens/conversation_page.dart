import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:training/adapterers/message_addapter.dart';
import 'package:training/chat_bloc.dart';
import 'package:training/main.dart';

class ConversationPage extends StatelessWidget {
  const ConversationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height -
          MediaQuery.of(context).size.height * 0.136,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          StreamBuilder<List<ChannelModel>>(
              stream: chatBloc.getChannel.stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text("No Data");
                }

                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, index) {
                    // ChannelModel? messageListElement = box.getAt(index);

                    // ChattMessage? chatMessageList = messageBox;
                    // Iterable<ChatMessageModel> chatMessageList =
                    //     messageBox.values.where((element) =>
                    //         element.chatID == messageListElement?.chatID);
                    // messageBox.get(messageListElement?.chatID);

                    // DateFormat dateFormat = DateFormat('dd MM yyyy');

                    final channelData = snapshot.data![index];
                    final chatData =
                        chatBloc.fetchLastMessage(channelData.channelID);

                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "chatScreen", arguments: {
                          "learningLanguage": channelData.language,
                          "topic": channelData.topic,
                          "image": channelData.channelImage,
                          "channelID": channelData.channelID,
                          "fromCreaterScreen": false
                        });
                      },
                      child: CnversationListWidget(
                        mainImage: channelData.channelImage,
                        date: " dd",
                        //  dateFormat.format(DateTime.parse(chatMessageList!.date)).toString(),
                        lastConversation: chatData.message,
                        roundLanguage: channelData.language.substring(0, 2),

                        topic: channelData.topic,
                        userName: chatData.userName,
                      ),
                    );
                  },
                );
              }),
          Positioned(
            bottom: 30,
            right: 40,
            child: ElevatedButton.icon(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: const BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, "startNewMessageScreen");
              },
              icon: const Icon(Icons.message),
              label: const Text(
                "Start a conversation",
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CnversationListWidget extends StatelessWidget {
  // final int index;
  final String mainImage;
  final String roundLanguage;
  final String topic;
  final String userName;
  final String lastConversation;
  // final String color;
  final String date;
  // final String smallDotColor;

  const CnversationListWidget({
    Key? key,
    required this.mainImage,
    required this.roundLanguage,
    required this.topic,
    required this.userName,
    required this.lastConversation,
    // required this.color,
    required this.date,
    // required this.smallDotColor,
    // this.index = 19,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16,
        left: 16,
        right: 16,
        // bottom: index == 19 ? 100 : 0,
        // bottom: index == 19 ? 100 : 0,
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Image.asset(
                        mainImage,
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 25,
                  right: 0,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        roundLanguage,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(topic),
                        Text(date),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("$userName: $lastConversation"),
                        Container(
                          height: 15,
                          width: 15,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
