import 'package:flutter/material.dart';
import 'package:wanted_umbrella/routes.dart';

import '../../utils/constants.dart';

class HelpPage extends StatelessWidget {
  HelpPage({Key? key}) : super(key: key);

  TextStyle style = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Help"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Swipe right on the profiles you like',style: style),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.favorite_border,size: 80),
                Icon(Icons.swipe_right_sharp, size: 80)
              ],
            ),
          ),
          Text('Swipe left on the profiles you dislike',style: style),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.close,size: 80),
              Icon(Icons.swipe_left_sharp, size: 80)
            ],
          ),
          Text('Tap to see profile photos',style: style),
          Icon(Icons.mobile_screen_share,size: 80),
          Center(
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: GetColors.purple),
              onPressed: () => Navigator.popUntil(context, ModalRoute.withName(Routes.dashboard)),
              child:
              const Text('Thank you', style: TextStyle(fontSize: 20, color: GetColors.white)),
            ),
          )

        ],
      ),
    );
  }
}
