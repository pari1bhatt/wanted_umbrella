import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wanted_umbrella/utils/utils.dart';

import '../../routes.dart';

class OnBoardingProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String regName = '';
  String regEmail = '';
  String regPassword = '';


  onRegister(BuildContext context) async {
    print("data check: ${regEmail}");
    try {
      await _auth.createUserWithEmailAndPassword(email: regEmail, password: regPassword);
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.scale,
        dismissOnTouchOutside: false,
        title: 'Registration Success',
        desc: 'You can now login with your email : $regEmail',
        btnCancelOnPress: () => Navigator.popUntil(context, ModalRoute.withName(Routes.login)),
        btnOkOnPress: () =>  Navigator.popUntil(context, ModalRoute.withName(Routes.login)),
      ).show();
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'email-already-in-use') {
        Utils.showSnackBar(context, "The email address is already in use by another account");
      }
    }
  }
}
