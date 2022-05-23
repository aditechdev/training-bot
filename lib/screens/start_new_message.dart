import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:training/const/newMessage_style.dart';

class StartNewMessageScreen extends StatefulWidget {
  const StartNewMessageScreen({Key? key}) : super(key: key);

  @override
  State<StartNewMessageScreen> createState() => _StartNewMessageScreenState();
}

class _StartNewMessageScreenState extends State<StartNewMessageScreen> {
  bool boolShowMyLanguageList = false;
  bool boolShowLearningLanguageList = false;
  List languageList = [
    "English",
    "Hindi",
    "Bengali",
    "Western Punjabi",
    "Yue Chinese",
    "Vietnamese",
    "Urdu",
    "Tamil",
    "Gujarati",
    "Bhojpuri",
    "Korean"
  ];
  String selectMyLanguage = "Select Language";
  String selectLearningLanguage = "Select Language";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        titleSpacing: 0,
        foregroundColor: Colors.black,
        title: Row(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  boolShowMyLanguageList = !boolShowMyLanguageList;
                });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "My Language",
                    style: appBarTitleStyle,
                  ),
                  Text(
                    selectMyLanguage,
                    style: appBarTitleSelectableStyle,
                  ),
                ],
              ),
            ),
            const Spacer(),
            SvgPicture.asset("assets/icons/ic_double_arrow.svg",
                color: Colors.blue),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: InkWell(
                onTap: () {
                  setState(() {
                    boolShowLearningLanguageList =
                        !boolShowLearningLanguageList;
                  });
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      "I am Learning",
                      style: appBarTitleStyle,
                    ),
                    Text(
                      selectLearningLanguage,
                      style: appBarTitleSelectableStyle,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Column(
            children: const [
              SizedBox(
                height: 40,
              ),
              MultiCircle(),
            ],
          ),
          boolShowMyLanguageList
              ? Positioned(
                  left: 55,
                  child: Column(
                    children: List.generate(
                      languageList.length,
                      (index) => InkWell(
                        onTap: () {
                          setState(() {
                            selectMyLanguage = languageList[index];
                            boolShowMyLanguageList = false;
                          });
                        },
                        child: DropDownLanguage(
                          languageList: languageList,
                          languageListText: languageList[index],
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
          boolShowLearningLanguageList
              ? Positioned(
                  right: 10,
                  child: Column(
                    children: List.generate(
                      languageList.length,
                      (index) => InkWell(
                        onTap: () {
                          setState(() {
                            selectLearningLanguage = languageList[index];
                            boolShowLearningLanguageList = false;
                          });
                        },
                        child: DropDownLanguage(
                          languageList: languageList,
                          languageListText: languageList[index],
                        ),
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}

class MultiCircle extends StatelessWidget {
  const MultiCircle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.green[300],
        ),
        child: Center(
          child: Container(
            height: 100,
            width: 100,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Center(
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue[200],
                ),
                child: Center(
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DropDownLanguage extends StatelessWidget {
  final String languageListText;
  const DropDownLanguage({
    Key? key,
    required this.languageList,
    required this.languageListText,
  }) : super(key: key);

  final List languageList;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      color: Colors.white,
      margin: const EdgeInsets.only(
        top: 10,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          languageListText,
          style: appBarTitleStyle,
        ),
      ),
    );
  }
}
