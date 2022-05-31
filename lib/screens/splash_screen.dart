import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScree extends StatelessWidget {
  const SplashScree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/homePage');
    });
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Lottie.asset("assets/animation/splashscreen.json"),
    );
  }
}
