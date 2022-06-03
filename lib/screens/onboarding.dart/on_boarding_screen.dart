import 'package:flutter/material.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({ Key? key }) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,

                  child: Column(
                    children: [
                      PageView.builder(
                        itemCount: 4,
                        
                        itemBuilder: (context,  index ){
                        return SizedBox(
                        height: 50,
                        width: 50,
                      );
                      }  )
                      

                    ],
                  ),
      
    );
  }
}