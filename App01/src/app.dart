import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;

import './img_mod.dart';
import './ImgList.dart';

import 'dart:convert';

class App extends StatefulWidget {
  createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  int counter = 0;
  List<ImgMod> img = [];

  void fetchImg() async{
    counter++;
    var res = await get('https://jsonplaceholder.typicode.com/photos/$counter');
    var imgMod = ImgMod.fromJson(json.decode(res.body));
    setState(() {
      img.add(imgMod);
    });
  }

  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('This is Title Bar'),
        ),
        body: ImgList(img),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: fetchImg,
        ),
      ),
    );
  }
}
