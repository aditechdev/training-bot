import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:training/adapterers/message_addapter.dart';
import 'package:training/chat_bloc.dart';
import 'package:training/screens/conversation_page.dart';
import 'package:training/screens/start_new_message.dart';
import 'package:training/widget/appBar_tab.dart';

import 'screens/chat_screen.dart';

const String channelBoxName = "channelModel";
const String chatBoxName = "chatModel";
main() async {
  
  await chatBloc.openBox(


  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "startNewMessageScreen": (context) => const StartNewMessageScreen(),
        "chatScreen": (context) => const ChatScreen()
      },
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int activeTabIndex = 0;

  List<Map<String, String>> tabList = [
    {'tabIcon': "assets/icons/ic_message.svg", 'tabLabel': "Conversation"},
    {'tabIcon': "assets/icons/ic_trend.svg", 'tabLabel': 'Trend'},
    {'tabIcon': "assets/icons/ic_video.svg", 'tabLabel': 'Video'},
    {
      'tabIcon': "assets/icons/ic_account_circle_icon.svg",
      'tabLabel': 'Account'
    },
  ];

  @override
  void initState() {
    chatBloc.fetchChannel();
    chatBloc.fetchChats();
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.1,
              color: Colors.grey[300],
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 6,
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        tabList.length,
                        (index) => TabWidget(
                          tabIcon: tabList[index]['tabIcon'].toString(),
                          tabLael: tabList[index]['tabLabel'].toString(),
                          activeTab: activeTabIndex == index,
                          onTap: () {
                            setState(() {
                              activeTabIndex = index;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ActiveTabScreen(
              activeTab: activeTabIndex,
            )
          ],
        ),
      ),
    );
  }
}

class ActiveTabScreen extends StatelessWidget {
  final int activeTab;
  const ActiveTabScreen({Key? key, required this.activeTab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (activeTab) {
      case 0:
        return const ConversationPage();

      case 1:
        return const Text("Trend Page Comming SOOON");
      case 2:
        return const Text("Hey I am Video");
      case 3:
        return const Text("This is AccountPage");
      default:
        return const Text("Something went wrong! Restart the app");
    }
  }
}
