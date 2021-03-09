import 'package:flutter/material.dart';

import '../constants.dart';

class Projects extends StatelessWidget {
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
                  title: Text("My Projects",
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
        body: Container(
          child: SingleChildScrollView(
            child: Column(
                children: List.generate(projects.length, (index) {
              return Column(children: [
                Center(
                  child: ProjectCard(project: projects[index]),
                ),
                SizedBox(
                  height: 10,
                )
              ]);
            })),
          ),
        ),
      ),
    );
  }
}

class Project {
  Project({this.title, this.subtitle});
  final String title;
  final String subtitle;
}

List<Project> projects = <Project>[
  Project(
      title: 'PlayOnn',
      subtitle: 'App for booking playgrounds for specific period'),
  Project(
      title: 'InstaEvents', subtitle: 'App for Hosting and Streaming Events'),
  Project(
      title: 'Mindfulness',
      subtitle: 'App for Meditation ideas and counselling'),
  Project(
      title: 'An Udemy Clone',
      subtitle: 'App for online courses like udemy and coursera'),
  Project(title: 'Fashion Beaver', subtitle: 'App for online shopping'),
  Project(title: 'Satyam Mega Mart', subtitle: 'App for grocery shopping'),
  Project(title: 'Ellvin Kanto', subtitle: ' An Ecommerce Application'),
  Project(title: 'PartyKsa', subtitle: 'An Ecommerce Application'),
];

class ProjectCard extends StatelessWidget {
  const ProjectCard({Key key, this.project}) : super(key: key);
  final Project project;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Center(
      child: Container(
        height: 140,
        width: 300,
        color: Colors.grey,
        padding: EdgeInsets.only(top: 12, left: 8, right: 8),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                project.title,
                style: TextStyle(
                    color: black,
                    fontFamily: "ArchitectsDaughter",
                    fontSize: 30),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                project.subtitle,
                style:
                    TextStyle(color: black, fontFamily: "PTSans", fontSize: 20),
              ),
            ]),
      ),
    ));
  }
}
