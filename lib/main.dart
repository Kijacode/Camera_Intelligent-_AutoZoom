import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iapp/app.dart';

void main(){
  //here application start
  //bind the widgets
  WidgetsFlutterBinding.ensureInitialized();
  //allow phone not rotate(potraits or horizontal)
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.red[400],
  statusBarBrightness: Brightness.light
  ));

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    .then((_) {
    runApp(MyApp());
    });
} 
