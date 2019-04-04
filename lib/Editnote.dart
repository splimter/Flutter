import 'package:flutter/material.dart';
import 'package:notes/DataBaseHelper.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqlite_api.dart';
import 'dart:ui';
import 'Drawer.dart';
import 'package:notes/Note.dart';
import 'Drawer.dart';
import 'package:notes/NoteView.dart';
import 'main.dart';

class EditNote extends StatefulWidget {
  final int turn;
  Note note;
  EditNote(this.turn, [this.note]);

  @override
  _EditNoteState createState() => _EditNoteState();
}

var now = new DateTime.now();
var formatter = new DateFormat('yyyy-MM-dd' + ' At ' + 'H:m');
Color notecolor = Colors.white;
 List clrbtns = [
    Color.fromARGB(255, 254, 212, 71),
    Color.fromARGB(255, 71, 254, 102),
    Color.fromARGB(255, 87, 148, 254),
    Color.fromARGB(255, 253, 136, 47),
    Color.fromARGB(255, 254, 71, 242),
    Color.fromARGB(255, 71, 199, 254),
    Color.fromARGB(255, 16, 254, 24),
    Color.fromARGB(255, 246, 254, 11),
    Color.fromARGB(255, 254, 11, 222),
    Color.fromARGB(255, 11, 254, 254),
    Color.fromARGB(255, 254, 112, 112),
  ];

List btns = new List();
void fill(){

        btns.clear();
        for(int i = 0 ; i<clrbtns.length-1 ; i++)
        {
          btns.add(new clrbtn1(Colors.white,clrbtns[i]));

        }  

}

class _EditNoteState extends State<EditNote> {
  double font = 15;
  String note;

  String btntext = 'Fethi';
  String headertxt;
  bool lnchbtn = false;
  int noteindex;

  
  bool stab = false;
  DatabaseHelper databaseHelper = DatabaseHelper();
 

  void handlestart() {
    setState(() {
        
      fill();
      now = new DateTime.now();
      if (widget.turn == 2) {
        headertxt = "Edit Note";
        btntext = 'Save Changes';
        _controller.text = widget.note.title;
        _controller.selection = new TextSelection.fromPosition(
            new TextPosition(offset: _controller.text.length));
        lnchbtn = true;
      } else {
        headertxt = "Add Note";
        btntext = 'Add Note';
      }
      if (stab) {
        for (int i = 0; i < clrbtns.length; i++) {
          if (clrbtns[i].on) {
            clrbtns[i].c = clrbtns[i].click;
            clrbtns[i].click = Colors.white;
            clrbtns[i].on = false;
          }
        }
        stab = false;
      }
    });
  }

  Container deletebtn() {
    if (widget.turn == 2)
      return new Container(
          child: IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
                size: 25,
              ),
              onPressed: () {
                setState(() {
                  databaseHelper.deleteNote(widget.note.id);
                  Navigator.pushReplacement(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => MyNotesPage()));
                });
              }));
    else
      return Container();
  }

  TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    handlestart();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        title: Text('$headertxt',
            style: TextStyle(
              color: Colors.white,
            )),
        iconTheme: new IconThemeData(color: Colors.white),
        actions: <Widget>[
          deletebtn(),
          IconButton(
            icon: Icon(
              Icons.save,
              color: Colors.blueAccent,
              size: 25,
            ),
            onPressed: () {
              setState(() {
                if (widget.turn != 2) {
                  if (_controller.text.length > 0) {
                    databaseHelper.insertNote(new Note(_controller.text,
                        formatter.format(now), notecolor.toString()));
                  }
                } else {
                  widget.note.title = _controller.text;
                  widget.note.description = notecolor.toString();
                  databaseHelper.updateNote(widget.note);
                }

                Navigator.pushReplacement(context,
                    new MaterialPageRoute(builder: (context) => MyNotesPage()));
              });
            },
          ),
        ],
      ),
      drawer: new DrawerOnly(),
      body: new Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            new SizedBox(
              height: 60,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: btns.length,
                  itemBuilder: (BuildContext context, int index) {
                    return btns[index];
                  }),
            ),
            new Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(left: 5, right: 5, top: 8, bottom: 5),
                padding: EdgeInsets.only(bottom: 2, top: 8, right: 5, left: 5),
                child: TextField(
                  maxLines: 24,
                  controller: _controller,
                  style: new TextStyle(wordSpacing: 2),
                  autocorrect: true,
                  decoration: new InputDecoration(
                      labelText: "Enter note here",
                      labelStyle: new TextStyle(fontSize: 16),
                      contentPadding: const EdgeInsets.only(left: 10, top: 20),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide:
                            BorderSide(width: 2, color: Colors.blueAccent),
                      )
                      //border:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20 ) ),borderSide: BorderSide(width: 15),)
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



}


class clrbtn1 extends StatefulWidget {

  Color c1;
  Color c2;
  clrbtn1(this.c1, this.c2);
  @override
  _clrbtn createState() => _clrbtn(c1 ,c2);

}

class _clrbtn extends State<clrbtn1>{
 

  Color c1;
  Color c2;
  _clrbtn(this.c1, this.c2);

  bool on = false;

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(color: c1,borderRadius: BorderRadius.all(Radius.circular(10) )),
      height: 10,
      margin: EdgeInsets.all(2),
      child: IconButton(
          padding: EdgeInsets.only(top: 0, left: 5, right: 5, bottom: 0),
          icon: Icon(Icons.blur_circular),
          color: c2,
          iconSize: 45,
          onPressed: () {
            setState(() {
              if (!on) {
                fill();
                c1 = c2;
                notecolor = c1;
                c2 = Colors.white;
                on = true ;
              } else {
                c2 = c1;
                c1 = Colors.white;
                notecolor = c1;
                on = false;
              }
            });
          }),
      /* blur_circular
          blur_on
          camera*/
    );
  }
  

}
