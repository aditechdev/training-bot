import 'package:flutter/material.dart';
import 'package:training/screens/conversation_page.dart';

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
