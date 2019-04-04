import 'package:flutter/material.dart';
import 'package:notes/NoteView.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fethi',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: new MyNotesPage(),
    );
  }
}

