import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanted_umbrella/pages/categories/categories_page.dart';
import 'package:wanted_umbrella/pages/dashboard_provider.dart';
import 'package:wanted_umbrella/pages/explore/explore_page.dart';
import 'package:wanted_umbrella/pages/profile/profile_page.dart';
import 'package:wanted_umbrella/utils/constants.dart';
import 'chat/chat_screen.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late DashboardProvider provider;
  List<IconData> listOfIcons = [
    Icons.handshake,
    Icons.message,
    Icons.category,
    Icons.person,
  ];
  int currentIndex = 0;
  late Size size;

  @override
  void initState() {
    super.initState();
    provider =Provider.of<DashboardProvider>(context,listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.getExploreData(context);
    });
  }

  @override
  void dispose() {
    provider.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: onPageSelection(),
      bottomNavigationBar: Container(
        height: size.width * .155,
        decoration: BoxDecoration(
          color: GetColors.white,
          boxShadow: [
            BoxShadow(color: GetColors.black.withOpacity(0.3), blurRadius: 5, offset: const Offset(0, 0)),
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
        return const ExplorePage();
      case 1:
        return const ChatScreen();
      case 2:
        return const CategoriesPage();
      case 3:
        return ProfilePage();
    }
  }
}
