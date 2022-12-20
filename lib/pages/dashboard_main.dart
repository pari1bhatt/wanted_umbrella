import 'package:flutter/material.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:wanted_umbrella/models/dog_data.dart';
import 'package:wanted_umbrella/utils/constants.dart';
import 'package:wanted_umbrella/utils/utils.dart';

import 'selection/selection_swipe_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<IconData> listOfIcons = [
    Icons.handshake,
    Icons.message,
    Icons.category,
    Icons.person,
  ];
  int currentIndex = 0;
  late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.blue,
          gradient: LinearGradient(
              colors: [Color(0xFFCC3DE5), Color(0xFF933DC8), Color(0xFF1647BF)],
              begin: FractionalOffset(0, 0),
              end: FractionalOffset(0.5, 1.2)),
        ),
        child: onPageSelection(),
      ),
      bottomNavigationBar: Container(
        height: size.width * .155,
        decoration: BoxDecoration(
          color: GetColors.white,
          boxShadow: [
            BoxShadow(color: GetColors.black.withOpacity(.15), blurRadius: 30, offset: const Offset(0, 10)),
          ],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(36)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
              4,
              (index) => InkWell(
                    onTap: () {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    splashColor: GetColors.transparent,
                    highlightColor: GetColors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 1500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          margin: EdgeInsets.only(
                            bottom: index == currentIndex ? 0 : size.width * .029,
                            right: size.width * .0422,
                            left: size.width * .0422,
                          ),
                          width: size.width * .128,
                          height: index == currentIndex ? size.width * .014 : 0,
                          decoration: const BoxDecoration(
                            color: GetColors.purple,
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(10),
                            ),
                          ),
                        ),
                        Icon(
                          listOfIcons[index],
                          size: size.width * .076,
                          color: index == currentIndex ? GetColors.purple : GetColors.grey,
                        ),
                        SizedBox(height: size.width * .03),
                      ],
                    ),
                  )),
        ),
      ),
    );
  }

  onPageSelection() {
    switch (currentIndex) {
      case 0:
        return const SelectionSwipePage();
      case 1:
        return const Center(child: Text("Messages - Coming Soon", style: TextStyle(color: GetColors.white)));
      case 2:
        return const Center(child: Text("Categories - Coming Soon", style: TextStyle(color: GetColors.white)));
      case 3:
        return const Center(child: Text("Profile - Coming Soon", style: TextStyle(color: GetColors.white)));
    }
  }
}
