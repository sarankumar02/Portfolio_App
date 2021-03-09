import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:portfolio/constants.dart';
import 'package:portfolio/ui/auth/signup.dart';
import 'package:portfolio/ui/homepage.dart';
import 'package:portfolio/ui/widgets/rounded_button.dart';
import 'package:portfolio/ui/widgets/rounded_textfield.dart';
import 'package:portfolio/ui/widgets/social_icon.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  String _userEmail;
  String gDisplayName;
  String fbData;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  GlobalKey<ScaffoldState> _loginPageKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    _userEmail = "";
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: _loginPageKey,
      body: Container(
        width: double.infinity,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets/images/main_top.png",
                width: size.width * 0.35,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                "assets/images/login_bottom.png",
                width: size.width * 0.4,
              ),
            ),
            Form(
              key: _loginFormKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Text(
                    //   "LOGIN",
                    //   style: TextStyle(fontWeight: FontWeight.bold),
                    // ),
                    SizedBox(height: size.height * 0.03),
                    SvgPicture.asset(
                      "assets/icons/login.svg",
                      height: size.height * 0.35,
                    ),
                    SizedBox(height: size.height * 0.03),
                    RoundedInputField(
                      hintText: "Your Email",
                      validator: (e) {
                        var email = _emailController.text;
                        bool emailValid = RegExp(
                                r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                            .hasMatch(email);
                        // print(emailValid);
                        if (!emailValid) return 'provide a valid email';
                      },
                      onChanged: (value) {},
                      controller: _emailController,
                    ),
                    RoundedInputField(
                      hintText: "password",
                      onChanged: (value) {},
                      controller: _passwordController,
                      validator: (e) {
                        if (e.length < 8) return 'Password is Wrong.Try Again';
                      },
                      icon: Icons.lock,
                    ),
                    // RoundedPasswordField(
                    //   onChanged: (value) {},
                    // ),
                    RoundedButton(
                      text: "LOGIN",
                      press: () async {
                        if (_loginFormKey.currentState.validate()) {
                          String result = await _signInWithEmailAndPassword(
                              email: _emailController.text,
                              password: _passwordController.text);
                          SnackBar snackBar = SnackBar(
                            content: Text(result),
                            duration: Duration(seconds: 1),
                          );
                          _loginPageKey.currentState.showSnackBar(snackBar);
                          if (result == "LOGIN SUCCESS") {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setBool('isLoggedIn', true);
                            Timer(Duration(seconds: 1), () async {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return HomePage();
                              }));
                            });
                          }
                        }
                      },
                    ),
                    SizedBox(height: size.height * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Don’t have an Account ? ",
                          style: TextStyle(color: kPrimaryColor),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return SignUpScreen();
                                },
                              ),
                            );
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: size.height * 0.02),
                      width: size.width * 0.8,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Divider(
                              color: Color(0xFFD9D9D9),
                              height: 1.5,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "OR",
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Color(0xFFD9D9D9),
                              height: 1.5,
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SocialIcon(
                          iconSrc: "assets/icons/facebook.svg",
                          press: () async {
                            String result = await _fbLogin();
                            SnackBar snackBar = SnackBar(
                              content: Text(result),
                              duration: Duration(seconds: 1),
                            );
                            print(result);
                            _loginPageKey.currentState.showSnackBar(snackBar);
                            if (result == "LOGIN SUCCESS") {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setBool('isLoggedIn', true);
                              Timer(Duration(seconds: 1), () async {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return HomePage();
                                }));
                              });
                            }
                          },
                        ),
                        SocialIcon(
                          iconSrc: "assets/icons/google-plus.svg",
                          press: () async {
                            String result = await _signInWithGoogle();
                            SnackBar snackBar = SnackBar(
                              content: Text(result),
                              duration: Duration(seconds: 1),
                            );
                            print(result);
                            _loginPageKey.currentState.showSnackBar(snackBar);
                            if (result == "LOGIN SUCCESS") {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setBool('isLoggedIn', true);
                              Timer(Duration(seconds: 1), () async {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return HomePage();
                                }));
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _signInWithEmailAndPassword({String email, String password}) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    _userEmail = "";
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      _userEmail = user.email;
    } catch (e) {
      return "${e.message}";
    }
    return _userEmail != ""
        ? "LOGIN SUCCESS"
        : "Something went wrong.Try Again";
  }

  Future _signInWithGoogle() async {
    gDisplayName = "";
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      UserCredential userCredential;

      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final GoogleAuthCredential googleAuthCredential =
          GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      userCredential = await _auth.signInWithCredential(googleAuthCredential);

      gDisplayName = userCredential.user.displayName;
    } catch (e) {
      return e.message;
    }
    return gDisplayName != ""
        ? "LOGIN SUCCESS"
        : "Something went wrong..Try Again";
  }

  Future _fbLogin() async {
    var _accessToken;
    fbData = "";
    try {
      _accessToken = await FacebookAuth.instance.login();

      final userData = await FacebookAuth.instance.getUserData();
      fbData = userData['name'];
    } on FacebookAuthException catch (e) {
      return e.message;
    } catch (e, s) {
      return e.message;
    }
    return fbData != "" ? "LOGIN SUCCESS" : "Something went Wrong...Try Again!";
  }
}
