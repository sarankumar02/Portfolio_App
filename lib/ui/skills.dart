import 'package:flutter/material.dart';

import '../constants.dart';

class Skills extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text("Skills",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "ArchitectsDaughter",
                          fontSize: 20.0,
                        )),
                    background: Image.network(
                      "http://images.unsplash.com/photo-1517999144091-3d9dca6d1e43?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MXwxMjA3fDB8MXxzZWFyY2h8Mnx8YmxhY2t8fDB8fHw&ixlib=rb-1.2.1&q=80&w=1080",
                      fit: BoxFit.cover,
                    )),
              ),
            ];
          },
          body: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 8.0,
              children: List.generate(choices.length, (index) {
                return Center(
                  child: SelectCard(choice: choices[index]),
                );
              }))),
    );
  }
}

class Choice {
  Choice({this.title, this.image});
  final String title;
  final String image;
}

List<Choice> choices = <Choice>[
  Choice(title: 'C', image: 'assets/images/c.png'),
  Choice(title: 'Python', image: 'assets/images/python.jpg'),
  Choice(title: 'Java', image: 'assets/images/java.jpg'),
  Choice(title: 'Dart', image: 'assets/images/dart.png'),
  Choice(title: 'Flutter', image: 'assets/images/flutter.png'),
  Choice(title: 'Android', image: 'assets/images/android.png'),
  Choice(title: 'Github', image: 'assets/images/github.png'),
  Choice(title: 'VS Code', image: 'assets/images/vscode.png'),
  Choice(title: 'Cli', image: 'assets/images/terminal.png'),
  Choice(title: 'Json', image: 'assets/images/json.jpg'),
  Choice(title: 'Rest Api', image: 'assets/images/rest.png'),
  Choice(title: 'Html', image: 'assets/images/html.jpg'),
  Choice(title: 'CSS', image: 'assets/images/css.jpg'),
  Choice(title: 'Django', image: 'assets/images/django.jpg'),
  Choice(title: 'Firebase', image: 'assets/images/firebase.jpg'),
  Choice(title: 'MYSql', image: 'assets/images/mysql.png'),
  Choice(title: 'Github', image: 'assets/images/github.png'),
];

class SelectCard extends StatelessWidget {
  const SelectCard({Key key, this.choice}) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Center(
      child: Container(
        padding: EdgeInsets.only(top: 12, left: 8, right: 8),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(choice.image, height: 60.0),
              Text(
                choice.title,
                style:
                    TextStyle(color: black, fontFamily: "PTSans", fontSize: 20),
              ),
            ]),
      ),
    ));
  }
}
