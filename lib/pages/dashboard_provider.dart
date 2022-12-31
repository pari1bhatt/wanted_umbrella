import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:wanted_umbrella/models/user_model.dart';
import 'package:wanted_umbrella/routes.dart';
import 'package:wanted_umbrella/utils/prefs.dart';
import 'package:wanted_umbrella/utils/utils.dart';

import '../models/dog_data.dart';
import 'on_boarding/on_boarding_provider.dart';

class DashboardProvider extends ChangeNotifier {
  var userCol = FirebaseFirestore.instance.collection('users');
  bool isExploreLoading = true;

  List<UserModel> exploreData = [];
  List<SwipeItem> swipeItems = [];
  MatchEngine? matchEngine;
  UserModel? currentUserModel;

  getExploreData(BuildContext context) async {
    OnBoardingProvider provider = Provider.of<OnBoardingProvider>(context,listen: false);
    currentUserModel = provider.currentUserModel;

    await userCol.where('email', isNotEqualTo: Prefs.getUserEmail()).get().then((value) async {
      print("value explore: ${value.docs.length}");
      exploreData = [];
      for (var document in value.docs) {
        var users = UserModel.fromJson(document.data());
        users.id = document.id;
        exploreData.add(users);
      }

      swipeItems = [];
      for (int i = 0; i < exploreData.length; i++) {
        swipeItems.add(SwipeItem(
            content: DogData(text: exploreData[i].name),
            likeAction: () {
              Utils.showSnackBar(context, "Liked ${exploreData[i].name}");
            },
            nopeAction: () {
              Utils.showSnackBar(context, "Nope ${exploreData[i].name}");
            },
            superlikeAction: () {
              Utils.showSnackBar(context, "Superliked ${exploreData[i].name}");
            },
            onSlideUpdate: (SlideRegion? region) async {
              print("Region $region");
            }));
      }
      matchEngine = MatchEngine(swipeItems: swipeItems);
      isExploreLoading = false;
      notifyListeners();
      print("notified");
    });
  }


}
