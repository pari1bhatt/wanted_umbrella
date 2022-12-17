import 'package:flutter/material.dart';
import 'package:wanted_umbrella/main.dart';
import 'package:wanted_umbrella/utils/constants.dart';

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

  bool _wrongEmail = false;
  bool _wrongPassword = false;

  String _emailText = 'Please use a valid email';
  String _passwordText = 'Please use a strong password';

  // final GoogleSignIn _googleSignIn = GoogleSignIn();
  //
  // final FirebaseAuth _auth = FirebaseAuth.instance;

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
                    errorText: _wrongEmail ? _emailText : null,
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
                    errorText: _wrongPassword ? _passwordText : null,
                  ),
                ),
                const SizedBox(height: 10.0),
              ],
            ),
            RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              color: GetColors.purple,
              onPressed: () async {
                // setState(() {
                //   _wrongEmail = false;
                //   _wrongPassword = false;
                // });
                // try {
                //   if (validator.isEmail(email) &
                //   validator.isLength(password, 6)) {
                //     setState(() {
                //       _showSpinner = true;
                //     });
                //     final newUser =
                //     await _auth.createUserWithEmailAndPassword(
                //       email: email,
                //       password: password,
                //     );
                //     if (newUser != null) {
                //       print('user authenticated by registration');
                //       Navigator.pushNamed(context, Done.id);
                //     }
                //   }
                //
                //   setState(() {
                //     if (!validator.isEmail(email)) {
                //       _wrongEmail = true;
                //     } else if (!validator.isLength(password, 6)) {
                //       _wrongPassword = true;
                //     } else {
                //       _wrongEmail = true;
                //       _wrongPassword = true;
                //     }
                //   });
                // } catch (e) {
                //   setState(() {
                //     _wrongEmail = true;
                //     if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
                //       _emailText =
                //       'The email address is already in use by another account';
                //     }
                //   });
                // }
              },
              child: const Text('Register', style: TextStyle(fontSize: 25, color: GetColors.white)),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 10.0),
            //       child: Container(
            //         height: 1.0,
            //         width: 60.0,
            //         color: Colors.black87
            //       ),
            //     ),
            //     const Text(
            //       'Or',
            //       style: TextStyle(fontSize: 25)
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 10.0),
            //       child: Container(
            //         height: 1.0,
            //         width: 60.0,
            //         color: Colors.black87,
            //       ),
            //     ),
            //   ],
            // ),
            // Row(
            //   children: [
            //     Expanded(
            //       child: RaisedButton(
            //         padding: EdgeInsets.symmetric(vertical: 5.0),
            //         color: Colors.white,
            //         shape: ContinuousRectangleBorder(
            //           side:
            //           BorderSide(width: 0.5, color: Colors.grey[400]),
            //         ),
            //         onPressed: () {
            //           onGoogleSignIn(context);
            //         },
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Image.asset('assets/images/google.png',
            //                 fit: BoxFit.contain,
            //                 width: 40.0,
            //                 height: 40.0),
            //             Text(
            //               'Google',
            //               style: TextStyle(
            //                   fontSize: 25.0, color: Colors.black),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //     SizedBox(width: 20.0),
            //     Expanded(
            //       child: RaisedButton(
            //         padding: EdgeInsets.symmetric(vertical: 5.0),
            //         color: Colors.white,
            //         shape: ContinuousRectangleBorder(
            //           side:
            //           BorderSide(width: 0.5, color: Colors.grey[400]),
            //         ),
            //         onPressed: () {
            //           //TODO: Implement facebook functionality
            //         },
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Image.asset('assets/images/facebook.png',
            //                 fit: BoxFit.cover, width: 40.0, height: 40.0),
            //             Text(
            //               'Facebook',
            //               style: TextStyle(
            //                   fontSize: 25.0, color: Colors.black),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
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
}
