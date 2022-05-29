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
  List<Map<String, String>> scrollImage = [
    {'image': "assets/images/restro.jpeg", 'label': "Restaurant"},
    {'image': "assets/images/petrolpump.jpeg", 'label': 'Petrol Pump'},
    {'image': "assets/images/hospital.jpeg", 'label': 'Hospital'},
  ];
  String selectMyLanguage = "Select Language";
  String selectLearningLanguage = "Select Language";
  int selectedIndex = 0;

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
            // const SizedBox(
            //   height: 40,
            // ),
            Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                const Text(
                  "Select One option",
                  style: TextStyle(fontSize: 20, color: Colors.black87),
                ),
                const SizedBox(
                  height: 40,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      scrollImage.length,
                      (index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: ScrollImage(
                          image: scrollImage[index]['image'].toString(),
                          bottomPadding: index == scrollImage.length - 1,
                          title: scrollImage[index]['label'].toString(),
                          selectedIcon: selectedIndex == index,
                        ),
                      ),
                    ),
                  ),
                )
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
        floatingActionButton: ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.send),
          label: Text("STart".toUpperCase()),
        ));
  }
}

class ScrollImage extends StatelessWidget {
  final String image;
  final bool bottomPadding;
  final String title;
  final bool selectedIcon;

  const ScrollImage({
    Key? key,
    required this.image,
    required this.bottomPadding,
    required this.title,
    this.selectedIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double cardSize = 150;
    return Padding(
      padding: EdgeInsets.only(left: 32, right: bottomPadding ? 50 : 0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(125)),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            Container(
              height: cardSize,
              width: cardSize,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.red),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                height: cardSize,
                width: cardSize,
              ),
            ),
            Container(
              height: cardSize,
              width: cardSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color.fromARGB(255, 0, 0, 0)
                    .withOpacity(selectedIcon ? 0.8 : 0.6),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    selectedIcon
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.verified,
                              color: Colors.green[400],
                              size: 30,

                              // style: const TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ],
        ),
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
