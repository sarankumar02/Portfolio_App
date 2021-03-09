import 'package:flutter/material.dart';

import '../constants.dart';

class Certificates extends StatelessWidget {
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
                title: Text("Certificates",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "ArchitectsDaughter",
                      fontSize: 20.0,
                    )),
                background: Image.network(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpRGa5PKBGGilvCdWBEfEnXfdcpNFkwdIEzQ&usqp=CAU",
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
              children: List.generate(certificates.length, (index) {
            return Column(children: [
              Center(
                child: CertificateCard(certificate: certificates[index]),
              ),
              SizedBox(
                height: 10,
              )
            ]);
          })),
        ),
      ),
    ));
  }
}

class Certificate {
  Certificate({this.title, this.image});
  final String title;
  final String image;
}

List<Certificate> certificates = <Certificate>[
  Certificate(title: 'Flutter Intern', image: 'assets/images/c3.jpeg'),
  Certificate(
      title: 'Ethical Hacking Workshop', image: 'assets/images/c1.jpeg'),
  Certificate(title: 'Flutter Intern', image: 'assets/images/c4.jpeg'),
  Certificate(
      title: 'Mobile App Development Intern', image: 'assets/images/c2.jpeg'),
];

class CertificateCard extends StatelessWidget {
  const CertificateCard({Key key, this.certificate}) : super(key: key);
  final Certificate certificate;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Center(
      child: Container(
        padding: EdgeInsets.only(top: 12, left: 8, right: 8),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(certificate.image, height: 200.0),
              Text(
                certificate.title,
                style:
                    TextStyle(color: black, fontFamily: "PTSans", fontSize: 20),
              ),
            ]),
      ),
    ));
  }
}
