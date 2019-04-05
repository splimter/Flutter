import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'CM.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
  static Database _database;                // Singleton Database

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + '<DBNAME>.db';

    // Open/create the database at a given path
    var <VarDBName> = await openDatabase(path, version: 1, onCreate: _createDb);
    return <VarDBName>;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(<SQL>);
  }

  // Fetch Operation: Get all objects from database
  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await this.database;

    var result = await db.query(<TabName>);
    return result;
  }

  // Insert Operation: Insert a object to database
  Future<int> insert(CM <CVar>) async {
    Database db = await this.database;
    var result = await db.insert(<TabName>,  <CVar>.toMap());
    return result;
  }

  // Update Operation: Update a object and save it to database
  Future<int> update(CM <CVar>) async {
    var db = await this.database;
    var result = await db.update(<TabName>,  <CVar>.toMap(), where: '$colId = ?', whereArgs: [ <CVar>.id]);
    return result;
  }

  // Delete Operation: Delete a object from database
  Future<int> delete(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $<TabName> WHERE $colId = $id');
    return result;
  }

  // Get number of objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $<TabName>');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'CM List' [ List<CM> ]
  Future<List<CM>> getNoteList() async {

    var CMMapList = await getCMMapList(); // Get 'Map List' from database
    int count = CMMapList.length;         // Count the number of map entries in db table

    List<CM> CMList = List<CM>();
    // For loop to create a 'CM List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      CMList.add(CM.fromMapObject(CMMapList[i]));
    }

    return CMList;
  }
}