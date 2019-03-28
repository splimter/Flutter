import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  String name, desc;
  double price;

  // Getters
  getName(s) {
    this.name = s;
  }

  getDesc(s) {
    this.desc = s;
  }

  getPrice(s) {
    this.price = double.parse(s);
  }

  //Action Button
  createData() {
    DocumentReference documentReference =
        Firestore.instance.collection("Product").document(name);
    Map<String, dynamic> product = {
      "name": name,
      "desc": desc,
      "price": price,
    };
    documentReference.setData(product).whenComplete(() {
      print('added');
    });
  }

  updateData() {
    DocumentReference documentReference =
        Firestore.instance.collection("Product").document(name);
    Map<String, dynamic> product = {
      "name": name,
      "desc": desc,
      "price": price,
    };
    documentReference.setData(product).whenComplete(() {
      print('update');
    });
  }

  readData() {
    DocumentReference documentReference =
        Firestore.instance.collection("Product").document(name);
    documentReference.get().then((datasnapshot) {
      print(datasnapshot.data["name"]);
      print(datasnapshot.data["desc"]);
      print(datasnapshot.data["price"]);
    });
  }

  deleteData() {
    DocumentReference documentReference =
        Firestore.instance.collection("Product").document(name);
    documentReference.delete().whenComplete(() {
      print('done');
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue,
        accentColor: Colors.cyan,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Hello'),
          ),
          body: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Name',
                  ),
                  onChanged: (String s) {
                    getName(s);
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Desciption',
                  ),
                  onChanged: (String s) {
                    getDesc(s);
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Price',
                  ),
                  onChanged: (String s) {
                    getPrice(s);
                  },
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: RaisedButton(
                          color: Colors.green,
                          child: Text('Create'),
                          onPressed: () {
                            createData();
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: RaisedButton(
                          color: Colors.blueAccent,
                          child: Text('Read'),
                          onPressed: () {
                            readData();
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: RaisedButton(
                          color: Colors.deepOrangeAccent,
                          child: Text('Update'),
                          onPressed: () {
                            updateData();
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: RaisedButton(
                          color: Colors.red,
                          child: Text('Delete'),
                          onPressed: () {
                            deleteData();
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text("name"),
                    ),
                    Expanded(
                      child: Text("desciption"),
                    ),
                    Expanded(
                      child: Text("price"),
                    ),
                  ],
                ),
                StreamBuilder(
                  stream: Firestore.instance.collection("Product").snapshots(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, i) {
                        DocumentSnapshot ds = snapshot.data.documents[i];
                        return Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(ds["name"].toString()),
                            ),
                            Expanded(
                              child: Text(ds["desc"].toString()),
                            ),
                            Expanded(
                              child: Text(ds["price"].toString()),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          )),
    );
  }
}
