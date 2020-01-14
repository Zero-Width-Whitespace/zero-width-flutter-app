import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  MaterialColor ThemeColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      title: 'Zero-Width Whitespace Encoder',
      theme: ThemeData(
        primaryColor: ThemeColor,
        accentColor: ThemeColor[800],
        primaryColorDark: ThemeColor[600]
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  HomePageState createState() => new HomePageState();
}