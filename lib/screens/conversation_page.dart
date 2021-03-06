import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:training/adapterers/message_addapter.dart';
import 'package:training/chat_bloc.dart';

class ConversationPage extends StatelessWidget {
  const ConversationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height -
          MediaQuery.of(context).size.height * 0.1361,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          StreamBuilder<List<ChannelModel>>(
              stream: chatBloc.getChannel.stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: Lottie.asset("assets/animation/loader.json"),
                  );
                }
                if (snapshot.data!.isEmpty) {
                  return Center(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child:
                              Lottie.asset("assets/animation/no_message.json"),
                        ),
                        const Text(
                          "Start a conversation 💬",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, index) {
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
                        date: chatData.getDate(),
                        lastConversation: chatData.message,
                        roundLanguage: channelData.language.substring(0, 2),
                        topic: channelData.topic,
                        userName: chatData.userName,
                        onTap: () {
                          // chatBloc.deleteChatsAndChannel(index);
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Delete this chat?"),
                                  actions: [
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text("No")),
                                    TextButton(
                                        onPressed: () {
                                          chatBloc.deleteChatsAndChannel(index);
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          "Yes",
                                          style: TextStyle(
                                            color: Colors.red,
                                          ),
                                        )),
                                  ],
                                );
                              });
                        },
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
  final Function() onTap;
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
    required this.onTap,
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
                        Text(
                          topic,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 16,
                            color: Colors.black87,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          date,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "$userName: ",
                          maxLines: 1,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.blue,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            lastConversation,
                            maxLines: 1,
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        InkWell(
                            onTap: onTap,
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ))
                        // Container(
                        //   height: 15,
                        //   width: 15,
                        //   decoration: const BoxDecoration(
                        //     color: Colors.green,
                        //     shape: BoxShape.circle,
                        //   ),
                        // )
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
