import 'package:flutter/material.dart';

import 'landingPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YANA',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        fontFamily: "Poppins",
      ),
      debugShowCheckedModeBanner: false,
      home: LandingPage(),
    );
  }
}
