import 'package:flutter/material.dart';

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
          Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children:
                    List.generate(100, (index) => Text("List of Conversation")),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            right: 40,
            child: ElevatedButton.icon(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: const BorderSide(color: Colors.blue)))),
              onPressed: () {
                print("Activate Me!");
              }, // TODO 1: Add FLOATING ACTION BUTTON functionn
              // TODO 2: Change message Icon
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
