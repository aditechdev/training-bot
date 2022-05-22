import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TabWidget extends StatelessWidget {
  final String tabIcon;
  final String tabLael;
  final bool activeTab;
  const TabWidget({
    Key? key,
    required this.tabIcon,
    required this.tabLael, required this.activeTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.yellow,
        child: Row(
          children: [
            SvgPicture.asset(
              tabIcon,
              height: 24,
              width: 24,
              color: Colors.black,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(tabLael)
          ],
        ));
  }
}
