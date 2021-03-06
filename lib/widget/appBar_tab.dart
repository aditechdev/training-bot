import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TabWidget extends StatelessWidget {
  final String tabIcon;
  final String tabLael;
  final bool activeTab;
  final Function() onTap;
  const TabWidget({
    Key? key,
    required this.tabIcon,
    required this.tabLael,
    this.activeTab = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: activeTab ? const Color(0xfffdf196) : Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                tabIcon,
                height: 24,
                width: 24,
                color: Colors.black,
              ),
              activeTab
                  ? const SizedBox(
                      width: 10,
                    )
                  : Container(),
              activeTab
                  ? Text(
                      tabLael,
                      style: const TextStyle(
                        color: Color(0xffe63946),
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
