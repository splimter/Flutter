import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatefulWidget {
  createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  SharedPreferences sharedPreferences;
  TextEditingController data = new TextEditingController();

  save() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.setString("variable", data.text);
    });
  }

  load() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      data.text = sharedPreferences.getString("variable");
    });
  }

  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('SharedPref'),
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: buildBase(),
        ),
      ),
    );
  }

  Widget buildBase() {
    return Center(
      child: Column(
        children: <Widget>[
          TextField(
            controller: data,
          ),
          RaisedButton(
              child: Text('ADD'),
              onPressed: () {save();}
              ),
          RaisedButton(
            child: Text('Shox'),
            onPressed: () {load();},
          )
        ],
      ),
    );
  }
}
