import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:portfolio/constants.dart';
import 'package:portfolio/ui/certificates.dart';
import 'package:portfolio/ui/projects.dart';

import 'about_me.dart';
import 'home.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Home(),
    AboutMe(),
    Projects(),
    Certificates()
  ];
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Color(0xffa98b98),

      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new

        items: [
          BottomNavigationBarItem(
            icon: new Icon(
              Icons.home,
              color: black,
            ),
            title: new Text(
              'Home',
              style: TextStyle(color: black),
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svgs/information.svg',
              height: 26,
            ),
            title: Text(
              'About ME',
              style: TextStyle(color: black),
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svgs/project-management.svg',
              height: 26,
            ),
            title: Text(
              'Projects',
              style: TextStyle(color: black),
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svgs/information.svg',
              height: 26,
            ),
            title: Text(
              'Certificates',
              style: TextStyle(color: black),
            ),
          ),
        ],
      ),
      body: _children[_currentIndex],
    );
  }
}
