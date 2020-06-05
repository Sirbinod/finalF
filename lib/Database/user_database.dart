import 'package:friendlocator/Model/user.dart';

import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DatabaseUser {
  static DatabaseUser _databaseUser; // Singleton DatabaseHelper
  DatabaseUser._privateConstructor();
  static final DatabaseUser instance = DatabaseUser._privateConstructor();
  static Database _database; // Singleton Database

  String userTable = 'user_table';
  String colId = 'id';
  String colName = 'name';
  String colMobile = 'mobile';
  String colGender = 'gender';
  String colAge = 'age';

  DatabaseUser._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseUser() {
    if (_databaseUser == null) {
      _databaseUser = DatabaseUser
          ._createInstance(); // This is executed only once, singleton object
    }
    return _databaseUser;
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
    String path = directory.path + 'Users.db';

    // Open/create the database at a given path
    var friendsDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return friendsDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $userTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, $colMobile TEXT, $colGender TEXT, $colAge Text)');
  }

  // Fetch Operation: Get all todo objects from database
  Future<List<Map<String, dynamic>>> getUserMapList() async {
    Database db = await this.database;

    //var result = await db.rawQuery('SELECT * FROM $friendTable order by $colName ASC');
    var result = await db.query(userTable, orderBy: '$colName ASC');
    return result;
  }

  // Insert Operation: Insert a todo object to database
  Future<int> insertUser(User user) async {
    Database db = await this.database;
    var result = await db.insert(userTable, user.toUserMap());
    return result;
  }

  // Update Operation: Update a todo object and save it to database
  Future<int> updateFriend(User user) async {
    var db = await this.database;
    var result = await db.update(userTable, user.toUserMap(),
        where: '$colId = ?', whereArgs: [user.id]);
    return result;
  }

  // Delete Operation: Delete a todo object from database
  Future<int> deleteUser(int id) async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $userTable WHERE $colId = $id');
    return result;
  }

  // Get number of todo objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $userTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(userTable);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $userTable'));
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'todo List' [ List<Todo> ]
  Future<List<User>> getUserList() async {
    var userMapList = await getUserMapList(); // Get 'Map List' from database
    int count =
        userMapList.length; // Count the number of map entries in db table

    List<User> userList = List<User>();
    // For loop to create a 'todo List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      userList.add(User.fromMapObject(userMapList[i]));
    }

    return userList;
  }

  Future<User> checkUser(String mobile) async {
    Database db = await instance.database;
    var res = await db.rawQuery("select * from users where mobile = '$mobile'");
    if (res.length > 0) {
      List<dynamic> list =
          res.toList().map((c) => User.fromMapObject(Map())).toList();

      print("Data " + list.toString());
      await db.insert("register", list[0].toUserMap());
      return list[0];
    }
    return null;
  }
}
