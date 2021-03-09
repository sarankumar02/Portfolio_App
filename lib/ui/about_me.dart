import 'package:flutter/material.dart';
import 'package:portfolio/ui/resume.dart';
import 'package:portfolio/ui/skills.dart';
import 'package:portfolio/ui/welcome.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

class AboutMe extends StatelessWidget {
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    String githubUrl = "http://github.com/sarankumar02";
    return Scaffold(
      key: _key,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text("About Me",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "ArchitectsDaughter",
                        fontSize: 20.0,
                      )),
                  background: Image.network(
                    "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                    fit: BoxFit.cover,
                  )),
            ),
          ];
        },
        body: Container(
          height: screenSize.height,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 30),
                Text(
                  'I am a Flutter developer with a year of experience in both frontend and backend. I also have a little experience in web development with skills like HTML, CSS, Django etc. I have developed many projects in flutter. Please check out my previous projects and certificates to know more.',
                  style: TextStyle(
                      color: black, fontFamily: "PTSans", fontSize: 22),
                ),
                SizedBox(
                  height: screenSize.height * 0.1,
                ),
                myButton(
                    text: "Github",
                    onPressed: () async {
                      print("Github");

                      if (await canLaunch(githubUrl)) {
                        launch(githubUrl);
                      } else {
                        SnackBar snackBar =
                            SnackBar(content: Text("Failed to launch URL"));
                        _key.currentState.showSnackBar(snackBar);
                      }
                    }),
                SizedBox(
                  height: screenSize.height * 0.05,
                ),
                myButton(
                    text: "Skills",
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Skills()));
                    }),
                SizedBox(
                  height: screenSize.height * 0.05,
                ),
                myButton(
                    text: "My Resume",
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ResumePage()));
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget myButton({String text, Function onPressed}) {
    return Container(
      height: 50,
      width: 200,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: Colors.red)),
        onPressed: onPressed,
        color: color2,
        textColor: Colors.white,
        child: Text(text.toUpperCase(),
            style: TextStyle(fontSize: 18, fontFamily: "ArchitectsDaughter")),
      ),
    );
  }
}
