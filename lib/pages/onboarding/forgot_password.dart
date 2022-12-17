import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:wanted_umbrella/main.dart';
import 'package:wanted_umbrella/utils/constants.dart';

class ForgotPassword extends StatelessWidget {
  // final _auth = FirebaseAuth.instance;
  ForgotPassword({Key? key}) : super(key: key);

  String email = '';

  // Future<void> resetPassword(String email) async {
  //   await _auth.sendPasswordResetEmail(email: email);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: GetColors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 60.0, bottom: 20.0, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              'Reset Password',
              style: TextStyle(fontSize: 40.0),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Enter your email',
                  style: TextStyle(fontSize: 30.0),
                ),
                const SizedBox(height: 20.0),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: const InputDecoration(hintText: 'Email'),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RaisedButton(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  color: GetColors.purple,
                  onPressed: () {
                    // resetPassword(email);
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.success,
                      animType: AnimType.scale,
                      title: 'Email Sent ✈️',
                      desc: 'Check your email to reset password!',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {},
                    ).show();
                  },
                  child: const Text('Reset Password', style: TextStyle(fontSize: 25, color: GetColors.white)),
                ),
                const SizedBox(height: 10),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context, Routes.login);
                    },
                    child: const Text(
                      'Back to Login',
                      style: TextStyle(fontSize: 20.0, color: GetColors.purple),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
