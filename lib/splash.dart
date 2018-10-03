import 'package:flutter/material.dart';
import 'package:clock/Intro.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.push(context,
            new MaterialPageRoute(builder: (context) => new IntroScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Color.fromARGB(255, 26, 115, 233),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration:
                  new BoxDecoration(color: Color.fromARGB(255, 26, 115, 233)),
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 50.0,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0),
                          ),
                          new Text(
                            "Clock",
                            style: new TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircularProgressIndicator(),
                          Padding(
                            padding: EdgeInsets.only(top: 20.0),
                          ),
                          new Text("A Clock",
                              style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold)),
                        ]),
                  ),
                ]),
          ],
        ));
  }
}
