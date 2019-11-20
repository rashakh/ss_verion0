import 'dart:async';
import 'dart:io';
import 'package:dtfbl/src/models/BG.dart';
import 'package:dtfbl/src/models/meal.dart';
import 'package:dtfbl/src/models/pressure.dart';
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
  
  // BG table:
  String BGTable= 'BG_table';
  //colEmail
  String colBGSlot = 'slot';
  String colBg='BG';
 // colnote
 String colDg='dg';

   // BP table:
  String BPTable= 'BP_table';
  //colEmail
  String colDiastolic = 'Diastolic';
  String colSystolic='Systolic';
 // colnote
 String colDp='dp';

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

    await db.execute('CREATE TABLE $BGTable ('
        '$colEmail TEXT,$colDg TEXT,$colBGSlot TEXT,'
        ' $colBg REAL,$colnote TEXT,PRIMARY KEY ($colEmail,$colDg))');
    
    await db.execute('CREATE TABLE $BPTable ('
        '$colEmail TEXT,$colDp TEXT,$colSystolic REAL,'
        ' $colSystolic REAL,$colnote TEXT,PRIMARY KEY ($colEmail,$colDp))');

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

 //delete
  Future<int> deleteUser(int id) async {
  	var db = await this.database;
  	int result = await db.rawDelete('DELETE FROM $mealTable WHERE $colId = $id');
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

 //delete one variety
  Future<int> deleteVariety(int id, int mealid) async {
  	var db = await this.database;
  	int result = await db.rawDelete('DELETE FROM $varietyTable WHERE $colid = $id AND $colId=$mealid');
  	return result;
  }

 //delete All varietise meal
  Future<int> deleteAllVarieteis(int id, int mealid) async {
  	var db = await this.database;
  	int result = await db.rawDelete('DELETE FROM $varietyTable WHERE $colId = $id');
  	return result;
  }
//----------------------------------BG Table--------------------------------------------------- 
//add
  Future<int> insertBG(BG bg) async {
    Database db = await this.database;
    var result = await db.insert(BGTable, bg.toMap());
    return result;
  }

//----------------------------------Prusser Table--------------------------------------------------- 
//add
  Future<int> insertBP(BP bp) async {
    Database db = await this.database;
    var result = await db.insert(BPTable, bp.toMap());
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