import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iapp/views/SplashScreen.dart';
import 'package:iapp/views/zoomPage.dart';


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //initialize boolean variable inorder to allow view according to platform
       bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    return isIOS ? CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: CupertinoThemeData(
        // This is the theme of your application.
       primaryColor: Colors.red[400]
       
      ),
      home: SplashScreen(),
    ) : MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
             primarySwatch: Colors.red[400],

      ),
      home: SplashScreen(),
    );
  }
}