import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanted_umbrella/pages/on_boarding/on_boarding_provider.dart';
import 'package:wanted_umbrella/routes.dart';
import 'package:wanted_umbrella/utils/constants.dart';
import 'package:wanted_umbrella/utils/prefs.dart';
import 'package:wanted_umbrella/utils/utils.dart';

// FirebaseUser _user;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';

  bool wrongEmail = false;
  bool wrongPassword = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;


  String emailText = 'Email doesn\'t match';
  String passwordText = 'password should be at least 6 letters';
  var presscount = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: GetColors.white,
        body: Container(
          padding: const EdgeInsets.only(top: 60, bottom: 20, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Login', style: TextStyle(fontSize: 40)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Welcome back,', style: TextStyle(fontSize: 25)),
                  Text('please login', style: TextStyle(fontSize: 25)),
                  Text('to your account', style: TextStyle(fontSize: 25)),
                ],
              ),
              Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Email',
                      labelText: 'Email',
                      errorText: wrongEmail ? emailText : null,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Password',
                      labelText: 'Password',
                      errorText: wrongPassword ? passwordText : null,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.forgot_password);
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(fontSize: 20.0, color: GetColors.purple),
                      ),
                    ),
                  ),
                ],
              ),
              TextButton(
                // padding: EdgeInsets.symmetric(vertical: 10),
                // color: GetColors.purple,
                style: TextButton.styleFrom(backgroundColor: GetColors.purple),
                onPressed: onLogin,
                child: const Text('Login', style: TextStyle(fontSize: 25, color: GetColors.white)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?', style: TextStyle(fontSize: 20)),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.register);
                    },
                    child: const Text(' Sign Up', style: TextStyle(fontSize: 20, color: GetColors.purple)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  onLogin() async {
    if (Utils.validateEmail(email)) {
      setState(() => wrongEmail = true);
    } else if (password.length < 6) {
      setState(() {
        wrongEmail = false;
        wrongPassword = true;
      });
    } else {
      Utils.showLoadingDialog(context);
      try {
        setState(() {
          wrongEmail = false;
          wrongPassword = false;
        });
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        await Prefs.setUserEmail(email);
        OnBoardingProvider provider = Provider.of<OnBoardingProvider>(context,listen: false);
        await provider.getCurrentUserData(context);
        Navigator.popUntil(context, ModalRoute.withName(Routes.login));
        if(provider.currentUserModel?.isKciApproved ?? false){
          Navigator.pushNamed(context, Routes.dashboard);
        } else {
          showKciDialog();
        }
      } on FirebaseAuthException catch (e) {
        print(e.code);
        Navigator.popUntil(context, ModalRoute.withName(Routes.login));
        if (e.code == 'wrong-password') {
          setState(() {
            wrongPassword = true;
            passwordText = 'Wrong password';
          });
        } else {
          setState(() {
            emailText = 'User doesn\'t exist';
            passwordText = 'Please check your email';

            wrongPassword = true;
            wrongEmail = true;
          });
        }
      }
    }
  }

  showKciDialog (){
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.scale,
      dismissOnTouchOutside: false,
      title: 'KCI not approved',
      desc: 'Please contact admin - wanted.umbrella27@gmail.com',
      btnCancel: null,
      btnOkOnPress: () => Navigator.popUntil(context, ModalRoute.withName(Routes.login)),
    ).show();
  }

  Future<bool> onWillPop() async {
    presscount++;
    if (presscount == 2) {
      exit(0);
    } else {
      Utils.showSnackBar(context, 'press another time to exit from app');
      return false;
    }
  }
}
