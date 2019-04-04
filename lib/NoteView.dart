import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:notes/DataBaseHelper.dart';
import 'package:sqflite/sqlite_api.dart';
import 'dart:ui';
import 'Editnote.dart';
import 'Drawer.dart';
import 'package:notes/Note.dart';

class MyNotesPage extends StatefulWidget {
  MyNotesPage();

  @override
  _MyNotesPageState createState() => _MyNotesPageState();
}

class _MyNotesPageState extends State<MyNotesPage> {
  int notesview = 2;
  IconData con = Icons.view_stream;
  _MyNotesPageState();

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;

  void updateListView() {

    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          if(noteList.length==0){
            databaseHelper.insertNote(new Note('Ill be alwasy here to cover your back', 'anytime ', 'Colors.blue'));
            updateListView();}
          else
            this.noteList = noteList;
        });
      });
    });
  }

  void _start() {

    setState(() {



      precacheImage(
          AssetImage(
              "assets/images/vors.jpg"
              ) ,context
          );
    });
  }


  @override
  Widget build(BuildContext context) {
    _start();
    if (noteList == null) {
      noteList = List<Note>();

      updateListView();

    }
    return Scaffold(
      drawer: new DrawerOnly(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            elevation: 15,
            backgroundColor: Color.fromARGB(255, 71, 199, 254),
            title: Text('Home',
                            style: TextStyle(
                              color: Colors.white,
                              )),
            iconTheme: new IconThemeData(color: Colors.white),
            floating: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  con,
                  color: Colors.white,
                  ),
                onPressed: () {
                  setState(() {

                    if (notesview == 2) {
                      notesview = 1;
                      con = Icons.view_quilt;
                    } else {
                      notesview = 2;
                      con = Icons.view_stream;
                    }
                  });
                },
                ),
            ],
            ),

          // new Container(),
          SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: notesview,
                ),
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  if (index < noteList.length) {
                    EdgeInsets.all(10);
                    return new CustomCard(noteList[(noteList.length-1) - index ] );
                  }
                },)
              ),
        ],
        ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 71, 199, 254),
        onPressed: () {
          Navigator.pushReplacement(context,
                                        new MaterialPageRoute(builder: (context) => EditNote(1)));
        },
        child: Icon(
          Icons.queue,
          color: Colors.white,
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      );
  }

}

class CustomCard extends StatefulWidget {
  CustomCard(this.note);
  Note note;

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {

  double font = 13;

  @override
  Widget build(BuildContext context) {
    return new Card(

      elevation: 2,
      margin: EdgeInsets.all(5),
      child: RaisedButton(

        splashColor: Colors.blueAccent,
        color: new Color(int.parse(widget.note.description.split('(0x')[1].split(')')[0] ,radix: 16)),
        onPressed: () {
          Navigator.pushReplacement(
              context,
              new MaterialPageRoute(
                  builder: (context) =>
                      EditNote(2,widget.note)));
        },

        padding: EdgeInsets.only(left: 5, top: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                new Text("${widget.note.title}",
                             style: new TextStyle(
                               fontSize: font,
                               )),
              ],
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 5, top: 5, right: 5),
                  child: Align(
                    alignment: Alignment(1, 0),
                    child: Text(widget.note.date,
                                    style: new TextStyle(
                                      fontSize: font,
                                      color: Colors.black54,
                                      )),
                    ),
                  ),
              ],
              ),
          ],
          ),
        ),
      );

  }



}
