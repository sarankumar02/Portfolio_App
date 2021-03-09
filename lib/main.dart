import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/ui/homepage.dart';
import 'package:portfolio/ui/splash.dart';
import 'package:portfolio/ui/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Portfolio-Saran',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        primaryColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var loggedIn;
  Future userDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loggedIn = prefs.getBool('isLoggedIn');
  }

  @override
  void initState() {
    super.initState();
    userDetail();
    Timer(
        Duration(seconds: 3),
        () => loggedIn != null || loggedIn == false
            ? Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomePage()))
            : Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => WelcomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Splash();
  }
}
