import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:url_launcher/url_launcher.dart';
import '../constants.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  String mobile = "91 9626653709";
  String email = "sarandhanush123@gmail.com";
  String instagramUrl = "https://www.instagram.com/sarankumar02";
  String linkedInUrl = "https://www.linkedin.com/in/saran-kumar-830039196";
  GlobalKey<ScaffoldState> _homeKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _homeKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('My Portfolio'),
        ),
        // backgroundColor: Colors.black12,
        body: Center(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.purple,
                      backgroundImage: AssetImage('assets/images/me.jpeg')),
                  SizedBox(height: 10),
                  Text(
                    'V.Sarankumar',
                    style: TextStyle(
                        color: black,
                        fontFamily: "PTSans",
                        fontSize: 35,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: screenSize.height * 0.03),
                  Text(
                    'Mobile App Developer and',
                    style: TextStyle(
                        color: Colors.black54,
                        fontFamily: "PTSans",
                        fontSize: 22),
                  ),
                  // SizedBox(height: 8),
                  Text(
                    'Web Developer',
                    style: TextStyle(
                        color: color2, fontFamily: "PTSans", fontSize: 22),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 80, right: 80),
                      child: Divider(
                        height: 50,
                        color: color3,
                      )),

                  myTile(
                      iconData: Icons.call,
                      content: "+ " + mobile,
                      onPressed: () {
                        UrlLauncher.launch('tel:+${mobile.toString()}');
                      }),
                  SizedBox(height: 15),
                  myTile(
                      iconData: Icons.email,
                      content: email,
                      onPressed: () {
                        UrlLauncher.launch(
                            "mailto:sarandhanush123@gmail.com?subject=Meeting&body=Can we have a little talk via Google Meet");
                      }),
                  SizedBox(height: screenSize.height * 0.035),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    socialWidget(
                        image: 'assets/images/linkedIn.png',
                        onPressed: () async {
                          if (await canLaunch(linkedInUrl)) {
                            launch(linkedInUrl);
                          } else {
                            SnackBar snackBar =
                                SnackBar(content: Text("Failed to launch URL"));
                            _homeKey.currentState.showSnackBar(snackBar);
                          }
                        }),
                    SizedBox(width: 50),
                    socialWidget(
                        image: 'assets/images/insta.jpg',
                        onPressed: () async {
                          if (await canLaunch(instagramUrl)) {
                            launch(instagramUrl);
                          } else {
                            SnackBar snackBar =
                                SnackBar(content: Text("Failed to launch URL"));
                            _homeKey.currentState.showSnackBar(snackBar);
                          }
                        }),
                  ])
                ],
              ),
            ),
          ),
        ));
  }

  Widget myTile({IconData iconData, String content, Function onPressed}) {
    return InkWell(
        onTap: onPressed,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              color: Colors.black,
            ),
            height: 50,
            width: screenSize.width * 0.9,
            padding: EdgeInsets.only(left: 20, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  iconData,
                  color: Colors.white,
                ),
                Text(
                  content,
                  style: TextStyle(color: Colors.white, fontSize: 15.5),
                ),
                SizedBox(width: 5)
              ],
            )));
  }

  Widget socialWidget({String image, Function onPressed}) {
    return InkWell(
      child: Image.asset(
        image,
        height: 32,
      ),
      onTap: onPressed,
    );
  }
}
