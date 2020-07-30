import 'package:flutter/material.dart';
import 'package:flutterapp/screens/home_page.dart';
import 'package:flutterapp/screens/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Today',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
    );
  }
}

class SplashPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () =>
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return HomePage();
        })));
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/logo.png", width: 300,),
            Text('Weather today',
              style: TextStyle(color: Colors.blueAccent, fontSize: 22),),
          ],
        ),
      ),
    );// This trailing comma makes auto-formatting nicer for build methods.
  }
}

