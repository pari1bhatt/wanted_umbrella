import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanted_umbrella/main.dart';
import 'package:wanted_umbrella/pages/on_boarding/on_boarding_provider.dart';
import 'package:wanted_umbrella/routes.dart';
import 'package:wanted_umbrella/utils/constants.dart';
import 'package:wanted_umbrella/utils/utils.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  bool wrongName = false;
  bool wrongEmail = false;
  bool wrongPassword = false;
  bool obsecurePass = true;

  String nameText = 'Please use a proper name';
  String emailText = 'Please use a valid email';
  String passwordText = 'Please choose a better password';

  late OnBoardingProvider onBoardingProvider;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    onBoardingProvider = Provider.of<OnBoardingProvider>(context);
    return Scaffold(
      backgroundColor: GetColors.white,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(top: 60.0, bottom: 20.0, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Register', style: TextStyle(fontSize: 50)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Lets get', style: TextStyle(fontSize: 30)),
                Text('you on board', style: TextStyle(fontSize: 30)),
              ],
            ),
            Column(
              children: [
                TextField(
                  keyboardType: TextInputType.name,
                  onChanged: (value) {
                    onBoardingProvider.userModel.name = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Full Name',
                    labelText: 'Full Name',
                    errorText: wrongName ? nameText : null,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    onBoardingProvider.userModel.email = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Email',
                    errorText: wrongEmail ? emailText : null,
                  ),
                ),
                const SizedBox(height: 20.0),
                TextField(
                  obscureText: obsecurePass,
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (value) {
                    onBoardingProvider.regPassword = value;
                  },
                  decoration: InputDecoration(
                      labelText: 'Password',
                      errorText: wrongPassword ? passwordText : null,
                      suffixIcon: IconButton(
                          onPressed: () => setState(() => obsecurePass = !obsecurePass),
                          icon: Icon(obsecurePass ? Icons.visibility : Icons.visibility_off))),
                ),
                const SizedBox(height: 10.0),
              ],
            ),
            TextButton(
              style: TextButton.styleFrom(backgroundColor: GetColors.purple),
              onPressed: onNext,
              child: const Text('Next', style: TextStyle(fontSize: 25, color: GetColors.white)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account?',
                  style: TextStyle(fontSize: 20),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context, Routes.login);
                  },
                  child: const Text(' Sign In', style: TextStyle(fontSize: 20, color: GetColors.purple)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  onNext() async {
    if (Utils.validateText(onBoardingProvider.userModel.name ?? '')) {
      setState(() => wrongName = true);
    } else if (Utils.validateEmail(onBoardingProvider.userModel.email ?? '')) {
      setState(() {
        wrongName = false;
        wrongEmail = true;
      });
    } else if (Utils.validatePassword(onBoardingProvider.regPassword)) {
      setState(() {
        wrongEmail = false;
        wrongPassword = true;
      });
    } else {
      setState(() {
        wrongName = false;
        wrongEmail = false;
        wrongPassword = false;
      });
      Navigator.pushNamed(context, Routes.dog_detail);
    }
  }
}
