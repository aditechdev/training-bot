import 'package:flutter/material.dart';
import 'package:training/screens/conversation_page.dart';
import 'package:training/widget/coming_soon_widget.dart';

class ActiveTabScreen extends StatelessWidget {
  final int activeTab;
  const ActiveTabScreen({Key? key, required this.activeTab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (activeTab) {
      case 0:
        return const ConversationPage();

      case 1:
        return const ComingSoonWidget(
          text: "Trend Page",
        );
      case 2:
        return const ComingSoonWidget(
          text: "Video Page",
        );
      case 3:
        return const ComingSoonWidget(
          text: "Account Page",
        );
      default:
        return const Text("Something went wrong! Restart the app");
    }
  }
}

