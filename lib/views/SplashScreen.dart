import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:iapp/views/zoomPage.dart';
import 'package:iapp/views/camera.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //timer which allow splash screen to display for 12 sec
  startTime() async {
    var _duration = new Duration(seconds: 12);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => new ZoomPage()));
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Padding(
            padding: EdgeInsets.only(left: 50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 50,
                    ),
                    Expanded(
                      child: Text("CCExtractor",
                          style:
                              TextStyle(color: Colors.red[400], fontSize: 30)),
                    )
                  ],
                ),
                SizedBox(
                    // height: MediaQuery.of(context).size.height - 285,
                    height: MediaQuery.of(context).size.height / 3),
                ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset("assets/gsoc.png")),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
