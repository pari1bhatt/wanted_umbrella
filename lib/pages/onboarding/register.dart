import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wanted_umbrella/main.dart';
import 'package:wanted_umbrella/utils/constants.dart';
import 'package:wanted_umbrella/utils/utils.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  String name = '';
  String email = '';
  String password = '';

  bool _showSpinner = false;

  bool wrongEmail = false;
  bool wrongPassword = false;

  String emailText = 'Please use a valid email';
  String passwordText = 'password should be at least 6 letters';

  // final GoogleSignIn _googleSignIn = GoogleSignIn();
  //
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Future<FirebaseUser> _handleSignIn() async {
  //   // hold the instance of the authenticated user
  //   FirebaseUser user;
  //   // flag to check whether we're signed in already
  //   bool isSignedIn = await _googleSignIn.isSignedIn();
  //   if (isSignedIn) {
  //     // if so, return the current user
  //     user = await _auth.currentUser();
  //   } else {
  //     final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  //     final GoogleSignInAuthentication googleAuth =
  //     await googleUser.authentication;
  //     // get the credentials to (access / id token)
  //     // to sign in via Firebase Authentication
  //     final AuthCredential credential = GoogleAuthProvider.getCredential(
  //         accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
  //     user = (await _auth.signInWithCredential(credential)).user;
  //   }
  //
  //   return user;
  // }

  // void onGoogleSignIn(BuildContext context) async {
  //   FirebaseUser user = await _handleSignIn();
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => GoogleDone(user, _googleSignIn)));
  // }

  @override
  Widget build(BuildContext context) {
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
                    name = value;
                  },
                  decoration: const InputDecoration(hintText: 'Full Name', labelText: 'Full Name'),
                ),
                const SizedBox(height: 20),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Email',
                    errorText: wrongEmail ? emailText : null,
                  ),
                ),
                const SizedBox(height: 20.0),
                TextField(
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Password',
                    errorText: wrongPassword ? passwordText : null,
                  ),
                ),
                const SizedBox(height: 10.0),
              ],
            ),
            TextButton(
              style: TextButton.styleFrom(backgroundColor: GetColors.purple),
              onPressed: onRegister,
              child: const Text('Register', style: TextStyle(fontSize: 25, color: GetColors.white)),
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

  onRegister() async {
    if (Utils.validateEmail(email)) {
      setState(() => wrongEmail = true);
    } else if (password.length < 6) {
      setState(() {
        wrongEmail = false;
        wrongPassword = true;
      });
    } else {
      setState(() {
        wrongEmail = false;
        wrongPassword = false;
      });
      try {
        setState(() {
          _showSpinner = true;
        });

        await _auth.createUserWithEmailAndPassword(email: email, password: password);
        Utils.showSnackBar(context, "User Registration done");
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        setState(() {
          wrongEmail = true;
          if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
            emailText = 'The email address is already in use by another account';
          }
        });
      }
    }
  }
}
