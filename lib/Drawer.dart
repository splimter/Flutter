import 'package:flutter/material.dart';
import 'package:notes/images.dart';
import 'Editnote.dart';
import 'main.dart';
import 'dart:io';
import 'package:notes/home.dart';
import 'dart:ui';
import 'package:notes/NoteView.dart';

class DrawerOnly extends StatefulWidget {
  final int pagenum;

  DrawerOnly({Key key, this.pagenum}) : super(key: key);

  @override
  _DrawerOnlyState createState() => _DrawerOnlyState();
}

class _DrawerOnlyState extends State<DrawerOnly> {
  ImageProvider c = AssetImage("assets/images/vors.jpg") ;

  @override
  Widget build(BuildContext ctxt) {

    return new Drawer(
      child: new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(image: c, fit: BoxFit.fill)),
          ),
          new ListTile(
            leading: Icon(Icons.home),
            title: new Text("Home"),
            onTap: () {
              Navigator.pushReplacement(
                  ctxt,
                  new MaterialPageRoute(
                      builder: (ctxt) => MyNotesPage()));
            },
            ),

          new ListTile(
            leading: Icon(Icons.add_box),
            title: new Text("ADD Notes"),
            onTap: () {
              Navigator.pushReplacement(
                  ctxt,
                  new MaterialPageRoute(
                      builder: (ctxt) => EditNote(1)));
            },
          ),
          new Divider(color: Colors.white, height: 260 ,),
          new Divider( height: 20 ,),
          new ListTile(

              leading: Icon(Icons.exit_to_app),
              title: new Text("Exit"),
              onTap: () {
                exit(0);
              }),
        ],
      ),
    );
  }
}

// DATA BASE
/*
Databashelper : create DB w contact and controll with the DataBase

UserApi : has all CRUD operations


colors to use
 rgb(90, 106, 249) blue //
 rgb(71, 254, 102) green //
 rgb(254, 102, 71) red   //
 rgb(254, 212, 71) orange //
 rgb(254, 71, 242) purple //
 rgb(71, 199, 254) light blue
 rgb(254, 248, 71) light orange //
 rgb(16, 254, 24)
 rgb(246, 254, 11)
 rgb(254, 11, 222)
 rgb(11, 254, 254)
 rgb(254, 11, 11)



*/

/*



textInputAction: TextInputAction.send, 

* 
* child aspectratio
* 
* FocusScope.of(context).requestFocus(new FocusNode());
* 
* 
* return new ConstrainedBox(
  constraints: new BoxConstraints(
    minHeight: 5.0,
    minWidth: 5.0,
    maxHeight: 30.0,
    maxWidth: 30.0,
  ),
  child: new DecoratedBox(
    decoration: new BoxDecoration(color: Colors.red),
  ),
);
* 
* */
/*

* 
* import 'package:intl/intl.dart';
* formattedDate
* 
* */

/*

* 
* class MyWidgetState extends State<MyWidget> {

  @override
  void initState() {
    // adjust the provider based on the image type
    precacheImage(new AssetImage('...'));
    super.initState();
  }

}
* 
* */
