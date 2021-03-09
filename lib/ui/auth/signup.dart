import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:portfolio/ui/auth/login.dart';
import 'package:portfolio/ui/widgets/rounded_button.dart';
import 'package:portfolio/ui/widgets/rounded_textfield.dart';

import '../../constants.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String _userEmail;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  Size size;
  GlobalKey<ScaffoldState> _signUpKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    _userEmail = "";
    return Scaffold(
      key: _signUpKey,
      body: Container(
        height: size.height,
        width: double.infinity,
        // Here i can use size.width but use double.infinity because both work as a same
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets/images/signup_top.png",
                width: size.width * 0.35,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                "assets/images/main_bottom.png",
                width: size.width * 0.25,
              ),
            ),
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20),
                    Text(
                      "SIGNUP",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: size.height * 0.03),
                    SvgPicture.asset(
                      "assets/icons/signup.svg",
                      height: size.height * 0.35,
                    ),
                    // roundedTextField(
                    //   hintText: "Your Email",
                    //   validator: (e) {
                    //     String email = _emailController.text;
                    //     bool emailValid = RegExp(
                    //             r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    //         .hasMatch(email);
                    //     if (emailValid) return 'provide a valid email';
                    //   },
                    //   controller: _emailController,
                    // ),
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
                        if (e.length < 8) return 'Provide a valid password';
                      },
                      icon: Icons.lock,
                    ),
                    // RoundedPasswordField(
                    //   onChanged: (value) {},
                    // ),
                    RoundedButton(
                      text: "SIGNUP",
                      press: () async {
                        if (_formKey.currentState.validate()) {
                          // print(_emailController.text);
                          // print(_passwordController.text);
                          String result = await _register(
                              email: _emailController.text,
                              password: _passwordController.text);
                          SnackBar snackBar = SnackBar(
                            content: Text(result),
                            duration: Duration(seconds: 1),
                          );
                          _signUpKey.currentState.showSnackBar(snackBar);
                          if (result == "Account Created Successfully") {
                            Timer(Duration(seconds: 1), () async {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return LoginScreen();
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
                          "Already have an Account ? ",
                          style: TextStyle(color: kPrimaryColor),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return LoginScreen();
                                },
                              ),
                            );
                          },
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),

                    SizedBox(height: 20)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _register({String email, String password}) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    _userEmail = "";
    // final User user = (await _auth.createUserWithEmailAndPassword(
    //   email: email,
    //   password: password,
    // ))
    //     .user;
    // _userEmail = user.email;
    try {
      User user = (await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;

      _userEmail = user.email;
    } catch (e) {
      return e.message;
    }
    // return _userEmail == ""
    //     ? "Authentication Failed..Try Again"
    //     : "Verfication Success";
    return _userEmail != ""
        ? "Account Created Successfully"
        : "Something went wrong.Try Again";
  }

  Widget roundedTextField(
      {Function validator,
      String hintText,
      IconData icon,
      TextEditingController controller}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: TextFormField(
        validator: validator,
        controller: controller,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
