import 'package:flutter/material.dart';
import 'package:training/chat_bloc.dart';
import 'package:training/widget/appBar_tab.dart';
import 'package:training/widget/main_tab.dart';

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
