import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather_app2/screens/weather_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  Splash createState() => Splash();
}

class Splash extends State<SplashScreen>  {

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 3),
            () =>
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => WeatherScreen())));


    var assetsImage = new AssetImage(
        'assets/images/Google-flutter-logo.png');
    var image = new Image(
        image: assetsImage,
        height:300

    ); //<- Creates a widget that displays an image.

    return Container(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: new BoxDecoration(color: Colors.white),
          child: new Center(
            child: image,
          ),
        ), //<- place where the image appears
      ),
    );
  }
}