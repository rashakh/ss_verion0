import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';

class DatabaseHelper {
  DatabaseHelper._createInctance();
  static DatabaseHelper _databaseHelper;
  static Database _database;

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
    String path = directory.path + 'user.db';
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
  }

  Future<int> insertUser(User user) async {
    Database db = await this.database;
    var result = await db.insert(userTable, user.toMap());
    return result;
  }

  Future<List<Map<String, dynamic>>> getUser(String email, String pass) async {
    Database db = await this.database;
    var result = await db.query(userTable, where: '$colEmail = ?', whereArgs: [email]);
    if (result.length > 0) {
      return result;
    }
    return null;
  }
}
