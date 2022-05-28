import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:training/adapterers/message_addapter.dart';

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
          ValueListenableBuilder(
              valueListenable:
                  Hive.box<MessageModel>('messageModel').listenable(),
              builder: (BuildContext context, Box<MessageModel> box, _) {
                if (box.values.isEmpty) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    child: const Center(
                        child: 
                        // CnversationListWidget(
                        //     // index: 1,
                        //     )
                        Text(
                          "The chat is empty",
                        ),
                        ),
                  );
                }

                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: ListView.builder(
                    itemCount: box.length,
                    itemBuilder: (BuildContext context, index) {
                      MessageModel? messageListElement = box.getAt(index);
                      return CnversationListWidget(
                        mainImage:  messageListElement!.image,
                      // color: "",
                      date: messageListElement.chatMessage[0].date,
                      lastConversation: messageListElement.chatMessage[0].message,
                      roundLanguage: messageListElement.language,
                      // smallDotColor: "",
                      topic: messageListElement.topic,
                      userName: messageListElement.chatMessage[0].userName,
                          // index: index,
                          );
                    },
                  ),
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
                Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      mainImage,
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
                    child:  Center(
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
                      children:  [
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
