import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:wanted_umbrella/models/user_model.dart';
import 'package:wanted_umbrella/routes.dart';
import 'package:wanted_umbrella/utils/prefs.dart';
import 'package:wanted_umbrella/utils/utils.dart';

import '../models/selection_model.dart';
import 'on_boarding/on_boarding_provider.dart';

class DashboardProvider extends ChangeNotifier {
  var userCol = FirebaseFirestore.instance.collection('users');
  bool isExploreLoading = true;

  List<UserModel> exploreData = [];
  List<SwipeItem> swipeItems = [];
  MatchEngine? matchEngine;
  UserModel? currentUserModel;

  List<SelectionModel> cartItems = [];

  getExploreData(BuildContext context) async {
    OnBoardingProvider provider = Provider.of<OnBoardingProvider>(context, listen: false);
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
            content: exploreData[i],
            likeAction: () {
              Utils.showSnackBar(context, "Liked ${exploreData[i].dog_name}");
            },
            nopeAction: () {
              Utils.showSnackBar(context, "Nope ${exploreData[i].dog_name}");
            },
            superlikeAction: () {
              Utils.showSnackBar(context, "Superliked ${exploreData[i].dog_name}");
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

  getFilteredData(String? breed, String? gender) async {
    if(breed != null && gender != null){
      var value = await FirebaseFirestore.instance
          .collection("users")
          .where('breed', isEqualTo: breed)
          .where('gender', isEqualTo: gender)
          .get();

      print("value explore: ${value.docs.length}");
    }
  }

  uploadImageToFirebase(File? file) async {
    String fileName = file!.path.split('/').last;
    try {
      Reference reference =
      FirebaseStorage.instance.ref().child('${currentUserModel?.email}/photos/$fileName');
      await reference.putFile(file);
      return await reference.getDownloadURL();
    } catch (e) {
    print('error occured');
    }
  }

  onUpdateProfile(UserModel? model, context,{String msg = 'Dog details updated'}) {
    userCol.doc(model!.id).update(model.toJson()).then((value) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.scale,
        dismissOnTouchOutside: false,
        title: 'Success',
        desc: msg,
        btnCancel: null,
        btnOkOnPress: () => Navigator.popUntil(context, ModalRoute.withName(Routes.dashboard)),
      ).show();
      currentUserModel = UserModel.fromJson(model.toJson());
      currentUserModel?.id = model.id;
      notifyListeners();
    });
  }

  reset() {
    exploreData = [];
    swipeItems = [];
    cartItems = [];
    matchEngine = null;
    isExploreLoading = true;
  }
}
