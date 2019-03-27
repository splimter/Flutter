import 'package:flutter/material.dart';
import './screens/home.dart';

class App extends StatefulWidget {
  createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  Widget build(context) {
    return MaterialApp(
      title: 'Aniamtion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
      );
  }
}
