import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ComingSoonWidget extends StatelessWidget {
  final String text;
  const ComingSoonWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset("assets/animation/CommingSoon.json"),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 20,
                color: Color(0xff5E5E5E),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
