import 'dart:async';
import 'dart:io';
import 'package:dtfbl/src/models/meal.dart';
import 'package:dtfbl/src/models/variety.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';

class DatabaseHelper {
  DatabaseHelper._createInctance();
  static DatabaseHelper _databaseHelper;
  static Database _database;

  // user table:
  String userTable = 'user_table';
  String colEmail = 'email';
  String colPass = 'Pass';
  String colFname = 'fname';
  String colLname = 'lname';
  String colDd = 'dd';
  String colBd = 'bd';
  String colGender = 'gender';
  String colType = 'type';
  String colHight = 'hight';
  String colWeight = 'weight';
  String colBmi = 'bmi';

// meal table:
  String mealTable = 'meal_table';
  String colId = 'mealId'; //auto
  //String _email;
  String colMealSlot = 'slot';
  String colCarb = 'totalCarb';
  String colnote = 'note';
  String coldm = 'dm';

// variety table:
  String varietyTable = 'variety_table';
  String colid = 'varId';
  //int _mealId;
  //String _email;
  String coleat = 'eat';
  String colvarcarb = 'varcarb';
  String colamount = 'amount';

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInctance();
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
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'user2.db';
    var userDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return userDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $userTable($colEmail TEXT PRIMARY KEY, $colPass TEXT,'
        '$colFname TEXT, $colLname TEXT, $colDd TEXT, $colBd TEXT,'
        '$colGender INTEGER, $colType INTEGER,'
        '$colHight REAL, $colWeight REAL, $colBmi REAL)');

    await db.execute(
        'CREATE TABLE $mealTable($colId INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$colEmail TEXT , $colMealSlot TEXT,'
        '$colCarb REAL, $colnote TEXT, $coldm TEXT)');

    await db.execute('CREATE TABLE $varietyTable ('
        '$colid INT,$colId INT,$coleat TEXT,'
        'colEmail TEXT, $colvarcarb REAL,'
        '$colamount REAL,PRIMARY KEY ($colid,$colId))');
  }

//----------------------------------User Table------------------------------------------
  //reg
  Future<int> insertUser(User user) async {
    Database db = await this.database;
    var result = await db.insert(userTable, user.toMap());
    return result;
  }

//login
  Future<List<Map<String, dynamic>>> getUser(String email, String pass) async {
    Database db = await this.database;
    var result =
        await db.query(userTable, where: '$colEmail = ?', whereArgs: [email]);
    if (result.length > 0) {
      return result;
    }
    return null;
  }

//--------------------------------Meal Table---------------------------------------------
//add
  Future<int> insertMeal(Meal meal) async {
    Database db = await this.database;
    var result = await db.insert(mealTable, meal.toMap());
  //  print(result);
    return result;
  }

//updaite  //not complite
  Future<int> updateMeal(Meal meal) async {
    var db = await this.database;
    var result = await db.update(mealTable, meal.toMap(),
        where: '$colId = ?', whereArgs: [meal.id]);
    return result;
  }

//get meals //not complite
  Future<List<Map<String, dynamic>>> getMeal(String email) async {
    Database db = await this.database;
    var result =
        await db.query(mealTable, where: '$colEmail = ?', whereArgs: [email]);
    if (result.length > 0) {
      return result;
    }
    return null;
  }
  //delete
  // Future<int> deleteUser(int id) async {
  // 	var db = await this.database;
  // 	int result = await db.rawDelete('DELETE FROM $UserTable WHERE $colId = $id');
  // 	return result;
  // }

//-------------------------------Variety Table--------------------------------------------
//add
  Future<int> insertVariety(Variety variety) async {
    Database db = await this.database;
    var result = await db.insert(varietyTable, variety.toMap());
    return result;
  }
//updaite  //not complite
  Future<int> updateVariety(Variety variety) async {
    var db = await this.database;
    var result = await db.update(mealTable, variety.toMap(),
        where: '$colId = ?', whereArgs: [variety.id]);
    return result;
  }
}











// 	// Fetch Operation: Get all User objects from database
// 	Future<List<Map<String, dynamic>>> getUserMapList() async {
// 		Database db = await this.database;

// //		var result = await db.rawQuery('SELECT * FROM $UserTable order by $colPriority ASC');
// 		var result = await db.query(UserTable, orderBy: '$colPriority ASC');
// 		return result;
// 	}





	// // Get number of User objects in database
	// Future<int> getCount() async {
	// 	Database db = await this.database;
	// 	List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $UserTable');
	// 	int result = Sqflite.firstIntValue(x);
	// 	return result;
	// }

	// // Get the 'Map List' [ List<Map> ] and convert it to 'User List' [ List<User> ]
	// Future<List<User>> getUserList() async {

	// 	var UserMapList = await getUserMapList(); // Get 'Map List' from database
	// 	int count = UserMapList.length;         // Count the number of map entries in db table

	// 	List<User> UserList = List<User>();
	// 	// For loop to create a 'User List' from a 'Map List'
	// 	for (int i = 0; i < count; i++) {
	// 		UserList.add(User.fromMapObject(UserMapList[i]));
	// 	}

	// 	return UserList;
	// }