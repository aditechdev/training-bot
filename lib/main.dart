import 'package:flutter/material.dart';
import 'package:training/chat_bloc.dart';
import 'package:training/screens/home_page.dart';
import 'package:training/screens/splash_screen.dart';
import 'package:training/screens/start_new_message.dart';

import 'screens/chat_screen.dart';

const String channelBoxName = "channelModel";
const String chatBoxName = "chatModel";
main() async {
  await chatBloc.openBox();
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
      initialRoute: "/splashScreen",
      routes: {
        "/splashScreen": (context) => const SplashScree(),
        "/homePage": (context) => const MyHomePage(),
        "startNewMessageScreen": (context) => const StartNewMessageScreen(),
        "chatScreen": (context) => const ChatScreen()
      },
    );
  }
}






// TODO 3:  Validate New Channel Page message
// TODO 4:  Design Account
// TODO 5:  Setup API for chat
// TODO 7:  Color Pick Up List
// TODO 8:  Sign in Page
// TODO 9:  Speach to text implementation
