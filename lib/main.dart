import 'package:flutter/material.dart';
import 'package:training/screens/conversation_page.dart';
import 'package:training/widget/appBar_tab.dart';

void main() {
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
        return const Text("Hey I am Trend");
      case 2:
        return const Text("Hey I am Video");
      case 3:
        return const ConversationPage();
      default:
        return Container(
          child: Text("Hey"),
        );
    }
  }
}
