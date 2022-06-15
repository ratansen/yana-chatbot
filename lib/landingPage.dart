import 'package:flutter/material.dart';
import 'chatScreen.dart';

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  primary: Colors.white,
  minimumSize: Size(290, 60),
  padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(50.0)),
  ),
  backgroundColor: Colors.pink,
);

class LandingPage extends StatefulWidget {
  LandingPage();
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 120,
              ),
              Image.asset(
                'assets/images/chat.gif',
                height: 250,
                // width: 40,
              ),
              Column(
                children: [
                  Text(
                    "Welcome to YANA",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "A chatbot that hates your loneliness",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                children: [
                  TextButton(
                      style: flatButtonStyle,
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ChatScreenPage();
                        }));
                      },
                      child: Text(
                        "Chat Now",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Developed with ❤ ️by Ratan",
                      style: TextStyle(fontSize: 8))
                ],
              ),
            ],
          )),
    );
  }
}
