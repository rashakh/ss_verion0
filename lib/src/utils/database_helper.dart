import 'dart:async';
import 'dart:io';
import 'package:dtfbl/src/models/A1C.dart';
import 'package:dtfbl/src/models/BG.dart';
import 'package:dtfbl/src/models/PA.dart';
import 'package:dtfbl/src/models/PT.dart';
import 'package:dtfbl/src/models/a1cexam.dart';
import 'package:dtfbl/src/models/carb.dart';
import 'package:dtfbl/src/models/dug.dart';
import 'package:dtfbl/src/models/exams.dart';
import 'package:dtfbl/src/models/meal.dart';
import 'package:dtfbl/src/models/med.dart';
import 'package:dtfbl/src/models/pressure.dart';
import 'package:dtfbl/src/models/variety.dart';
import 'package:dtfbl/src/models/wieght.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
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
  String colnumber = 'number';

// meal table:
  String mealTable = 'meal_table';
  String colId = 'mealId'; //auto
  //String _email;
  String colMealSlot = 'slot';
  String colCarb = 'totalCarb';
  String colnote = 'note';
  String coldate = 'date';

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
// String colDg='dg';

   // BP table:
  String BPTable= 'BP_table';
  //colEmail
  String colDiastolic = 'Diastolic';
  String colSystolic='Systolic';
 // colnote
// String colDp='dp';


//BW table:
  String BWTable= 'BW_table';
 // String _email;
  String colwieght='wieght';
 // double _bmi;
 // String _note;
 // String _dw;

//Instruction table:
  String instrTable= 'Instr_table';
  String colAototId = 'id'; //auto
  String coltitel='titel';
  String coldes='des';

//PA table:
  String PATable= 'PA_table';
    // this._email = map['email'];
  String colName = 'Name';
  //String colPAid='id'; //auto
  String coldur = 'dur';
  //  this._dg = map['date'];

//PT table:
  String PTTable= 'PT_table';
//  String colName = 'Name';
  //String colPTid='id'; //auto

//A1C table:
  String A1CTable= 'A1C_table';
//  String colName = 'Name';
 // String colid='id'; //auto
  String colA1C='a1C';
  String coldS='dateS';
  String coldE='dateE';

//CARB table:
  String CarbTable= 'Carb_table';
  //String colName = 'Name';
  //String colA1Cid='id'; //auto
  String colcurnt='curnt';
  String colmin='min';
  String colmax='max';
  //String _Dc;

//Exams table:
  String ExamsTable= 'Exams_table';
  //String _id;//auto
  String colPTId='PTId';
  //String _email;
  //String _name;
  //String _dur;
  //String _date;
  String colresult='result';
  String colRDate='RDate';

//ExamA1C table:
  String ExamA1CTable= 'ExamA1C_table';
  //String _id;//auto
  //String _PTId='PTId';
  //String _email;
  //String _name;
  //String _dur;
  //String _date;
  //String _result='result';
  //String _RDate='RDate';

//med table:
  //int _id; //auto
  //String _Name;
  String MedTable= 'med_table';
  String colconf='conf';
  String colwork='work';
  String colsid='sid';


//dug table:
  String DugTable= 'Dug_table';
  //int _id; //auto
  //String _email;
  //String _Name;
  //String _type;
  String coldug='dug';


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
    String path = directory.path + 'user6.db';
    var userDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return userDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $userTable('
          '$colEmail TEXT PRIMARY KEY, $colPass TEXT,'
        '$colFname TEXT, $colLname TEXT, $colDd TEXT, $colBd TEXT,'
        '$colGender INTEGER, $colType INTEGER,'
        '$colHight REAL,$colnumber TEXT)');

    await db.execute('CREATE TABLE $mealTable('
        '$colId INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$colEmail TEXT , $colMealSlot TEXT,'
        '$colCarb REAL, $colnote TEXT, $coldate TEXT)');

    await db.execute('CREATE TABLE $varietyTable ('
        '$colid INT,$colId INT,$coleat TEXT,'
        'colEmail TEXT, $colvarcarb REAL,'
        '$colamount REAL,PRIMARY KEY ($colid,$colId))');

    await db.execute('CREATE TABLE $BGTable ('
        '$colEmail TEXT,$coldate TEXT,$colBGSlot TEXT,'
        ' $colBg INT,$colnote TEXT,PRIMARY KEY ($colEmail,$coldate))');
    
    await db.execute('CREATE TABLE $BPTable ('
        '$colEmail TEXT,$coldate TEXT,$colSystolic INT,'
        ' $colDiastolic INT,$colnote TEXT,PRIMARY KEY ($colEmail,$coldate))');

     await db.execute('CREATE TABLE $BWTable ('
        '$colEmail TEXT,$coldate TEXT,$colwieght INT,'
        ' $colBmi REAL,$colnote TEXT,PRIMARY KEY ($colEmail,$coldate))');

    await db.execute('CREATE TABLE $instrTable('
    '$colAototId INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$coltitel TEXT , $coldes TEXT)');

    await db.execute('CREATE TABLE $PATable('
        '$colAototId INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$colEmail TEXT ,$coldate TEXT ,$colName TEXT , $coldur REAL)');

    await db.execute('CREATE TABLE $PTTable('
        '$colAototId INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$colName TEXT)');
  
    await db.execute( 'CREATE TABLE $A1CTable('
    '$colAototId INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$coldS TEXT ,$coldE TEXT ,$colA1C TEXT)');

    await db.execute('CREATE TABLE $ExamsTable('
        '$colAototId INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$colEmail TEXT, $colPTId INTEGER,'
        '$colName TEXT, $coldate TEXT, $colresult TEXT, $colRDate TEXT,'
        '$coldur INTEGER)');

    await db.execute('CREATE TABLE $ExamA1CTable('
        '$colAototId INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$colEmail TEXT, $colPTId INTEGER,'
        '$colName TEXT, $coldate TEXT, $colresult TEXT, $colRDate TEXT,'
        '$coldur INTEGER)');
    
    await db.execute( 'CREATE TABLE $CarbTable('
    '$colAototId INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$colcurnt REAL ,$colmin REAL ,$colmax REAL,$coldate TEXT )');

    await db.execute( 'CREATE TABLE $DugTable('
    '$colAototId INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$colEmail TEXT ,$colName TEXT ,$colType TEXT,$coldug INTEGER )');

    await db.execute( 'CREATE TABLE $MedTable('
    '$colAototId INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$colconf TEXT ,$colName TEXT ,$colwork TEXT,$colsid TEXT )');
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

//get total BG
Future BGTotal() async {
  var dbClient = await this.database;
  var result = await dbClient.rawQuery("SELECT SUM($colBg) as Total FROM $BGTable");
  //print(result.toList());
  return result.toList();
}

// nuber of record:
Future BGRecord() async {
 Database db = await this.database;
var result = await db.rawQuery('SELECT COUNT(*) as r FROM $BGTable');
  print(result.toList());
  return result.toList();
}

//----------------------------------Prusser Table--------------------------------------------------- 
//add
  Future<int> insertBP(BP bp) async {
    Database db = await this.database;
    var result = await db.insert(BPTable, bp.toMap());
    return result;
  }
  
//----------------------------------Wieght Table--------------------------------------------------- 
//add
  Future<int> insertBW(BW bw) async {
    Database db = await this.database;
    var result = await db.insert(BWTable, bw.toMap());
    return result;
  }

//----------------------------------Instruction Table--------------------------------------------------- 

//get one Instruction
  Future<List<Map<String, dynamic>>> getInstruction(int id) async {
    Database db = await this.database;
    var result =
        await db.query(instrTable, where: '$colAototId = ?', whereArgs: [id]);
    if (result.length > 0) {
      return result;
    }
    return null;
  }
//get All Instruction
Future<List<Map<String, dynamic>>> getInstructionMapList() async {
		Database db = await this.database;
		var result = await db.query(instrTable, orderBy: '$colAototId ASC');
		return result;
	}

//----------------------------------PA Table--------------------------------------------------- 
//ADD
//add
  Future<int> insertPA(PA pa) async {
    Database db = await this.database;
    var result = await db.insert(PATable, pa.toMap());
print('updated: $result');
    return result;
  }
//UPDATE //not complet
  Future<int> UpdatetPA(int pa) async {
    Database db = await this.database;
 //   int count = await database.rawUpdate(SELECT * FROM tablename ORDER BY column DESC LIMIT 1);
    var result = await db.rawQuery('SELECT * FROM $PATable ORDER BY $colAototId DESC LIMIT 1');
   // var result1 = await db.update(PATable, pa.map(), where: '$colAototId = ?', whereArgs: [variety.id]));
    var result1 = await db.rawUpdate('UPDATE $PATable  SET $coldur = $pa  WHERE colAototId=${result[0]['id']}');
print('updated: $result');
print('updated 1: $result1');
    return result1;
  }
//GET IN RENGE
//----------------------------------PT Table--------------------------------------------------- 
//add
  Future<int> insertPT(PT pt) async {
    Database db = await this.database;
    var result = await db.insert(PTTable, pt.toMap());
    return result;
  }
//GET
//UPDATE
//----------------------------------A1C Table--------------------------------------------------- 
//add
  Future<int> insertA1C(A1C a1c) async {
    Database db = await this.database;
    var result = await db.insert(A1CTable, a1c.toMap());
    return result;
  }
  
//UPDATE
//GET All
// value of A1C:
Future getA1C() async {
 Database db = await this.database;
var result = await db.rawQuery('SELECT COUNT(*) as r FROM $BGTable');
 // print(result.toList());
  return result.toList();
}


//GET All with date

//DELETE
//----------------------------------CARB Table--------------------------------------------------- 
//add
  Future<int> insertCARB(Carb pa) async {
    Database db = await this.database;
    var result = await db.insert(CarbTable, pa.toMap());
    return result;
  }

//UPDATE
//GET

//----------------------------------Exam Table---------------------------------------------------
//add
  Future<int> insertExam(Exam pa) async {
    Database db = await this.database;
    var result = await db.insert(ExamsTable, pa.toMap());
    return result;
  }
//UPDATE
//GET
//----------------------------------ExamA1C Table------------------------------------------------
//add
  Future<int> insertExamA1C(ExamA1C pa) async {
    Database db = await this.database;
    var result = await db.insert(ExamA1CTable, pa.toMap());
    return result;
  }
//UPDATE
//GET
//----------------------------------med table----------------------------------------------------
//ADD
  Future<int> insertmed(Med pa) async {
    Database db = await this.database;
    var result = await db.insert(MedTable, pa.toMap());
    return result;
  }
//UPDATE
//GET

//----------------------------------dug table----------------------------------------------------
//ADD
  Future<int> insertDUB(Dug pa) async {
    Database db = await this.database;
    var result = await db.insert(DugTable, pa.toMap());
    return result;
  }
  
//UPDATE
//GET







// // delet database:
// Future<int> DB(Srting pa) async {
//     Database db = await this.database;
//     var result = await db.insert(DugTable, pa.toMap());
//     return result;
//   }

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