import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:wanted_umbrella/models/selection_model.dart';
import 'package:wanted_umbrella/models/user_model.dart';
import 'package:wanted_umbrella/utils/prefs.dart';
import 'package:wanted_umbrella/utils/utils.dart';

import '../../routes.dart';

class OnBoardingProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var userCol = FirebaseFirestore.instance.collection('users');
  UserModel userModel = UserModel();
  UserModel? currentUserModel;

  String regPassword = '';

  List<File?> imageList = [];
  PlatformFile? selectedFile;
  List<SelectionModel> personalities = [
    SelectionModel(text: 'Active'),
    SelectionModel(text: 'Affectionate'),
    SelectionModel(text: 'Barker'),
    SelectionModel(text: 'Calm'),
    SelectionModel(text: 'Clever'),
    SelectionModel(text: 'Energetic'),
    SelectionModel(text: 'Foodie'),
    SelectionModel(text: 'Friendly'),
    SelectionModel(text: 'Gentle'),
    SelectionModel(text: 'Happy'),
    SelectionModel(text: 'Lazy'),
    SelectionModel(text: 'Playful'),
    SelectionModel(text: 'Protective'),
    SelectionModel(text: 'Relaxed'),
    SelectionModel(text: 'Runner'),
    SelectionModel(text: 'Shy'),
    SelectionModel(text: 'Silly'),
    SelectionModel(text: 'Smart'),
    SelectionModel(text: 'Wrestler'),
  ];

  onRegister(BuildContext context) async {
    print("data check: ${userModel.toJson()}");

    Utils.showLoadingDialog(context);

    if (await registerFirebaseAuth(context) &&
        await uploadImagesToFirebase() &&
        await uploadFileToFirebase() &&
        await addDataToFirebase()) {
      Navigator.popUntil(context, ModalRoute.withName(Routes.choose_personality));
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.scale,
        dismissOnTouchOutside: false,
        title: 'Registration Success',
        desc: 'You can now login with your email : ${userModel.email}',
        btnCancel: null,
        btnOkOnPress: () {
          reset();
          Navigator.popUntil(context, ModalRoute.withName(Routes.login));
        },
      ).show();
    } else {
      Navigator.popUntil(context, ModalRoute.withName(Routes.choose_personality));
    }
  }

  registerFirebaseAuth(BuildContext context) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: userModel.email!, password: regPassword);
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'email-already-in-use') {
        Utils.showSnackBar(context, "The email address is already in use by another account");
      }
      return false;
    }
  }

  uploadImagesToFirebase() async {
    List<String> URLs = [];
    for (var element in imageList) {
      String fileName = element!.path.split('/').last;
      try {
        Reference reference =
            FirebaseStorage.instance.ref().child('${userModel.email}/photos/$fileName');
        await reference.putFile(element);
        URLs.add(await reference.getDownloadURL());
      } catch (e) {
        print('error occured');
      }
    }
    userModel.dog_images = URLs;
    return true;
  }

  uploadFileToFirebase() async {
    File kciFile = File(selectedFile!.path!);
    String fileName = kciFile.path.split('/').last;
    try {
      Reference reference =
          FirebaseStorage.instance.ref().child('${userModel.email}/kci/$fileName');
      await reference.putFile(kciFile);
      userModel.kci_certificate = await reference.getDownloadURL();
    } catch (e) {
      print('error occured');
    }
    return true;
  }

  addDataToFirebase() async {
    userModel.created = Timestamp.now();
    try {
      var value = await FirebaseFirestore.instance.collection("users").add(userModel.toJson());
      debugPrint('value.id : ${value.id}');
    } catch (e) {
      debugPrint("Failed to add new data due to $e");
    }
    return true;
  }

  int selectedPersonalities() {
    int i = 0;
    for (var a in personalities) {
      if (a.isSelected) {
        i++;
      }
    }
    return i;
  }

  addPersonalities() {
    userModel.personalities = [];
    for (SelectionModel a in personalities) {
      if (a.isSelected) {
        userModel.personalities?.add(a.text!);
      }
    }
  }

  getCurrentUserData(BuildContext context) async {
    var value = await userCol.where('email', isEqualTo: Prefs.getUserEmail()).get();
    print("value: ${value.docs.length}");
    if (value.docs.length == 1) {
      currentUserModel = null;
      value.docs.forEach((document) {
        currentUserModel = UserModel.fromJson(document.data());
        currentUserModel?.id = document.id;
      });
    } else {
      Utils.showSnackBar(context, "Something went wrong");
    }
  }

  reset() {
    userModel = UserModel();
    regPassword = '';
    imageList = [];
    selectedFile = null;
    personalities.forEach((e) => e.isSelected = false);
  }
}
