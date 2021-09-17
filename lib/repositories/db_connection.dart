
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection {
  setDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'jobber.db');
    var database = await openDatabase(path, version: 1, onCreate: _onCreateDatabase);
    return database;
  }

  _onCreateDatabase(Database db, int version) async {
    await db.execute('CREATE TABLE categories('
        'id INTEGER PRIMARY KEY, '
        'name TEXT, '
        'description TEXT) '
    );
  }

}


// class DatabaseHelper{
//   static final _dbName = 'jober.db';
//   static final _dbVersion = 1;
//   static final _tableName = 'myTable';
//
//   static final columnId = '_id';
//   static final columnName = 'name';
//   static final columnDescription = 'description';
//
//   DatabaseHelper._privateConstructor();
//   static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
//
//   static late Database _database;
//   Future<Database> get database async {
//     if(_database != null) return _database;
//
//     _database = await _initiateDatabase();
//     return _database;
//   }
//
//   _initiateDatabase () async {
//     Directory directory = await getApplicationDocumentsDirectory();
//     String path = join(directory.path, _dbName);
//     await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
//   }
//
//   Future _onCreate(Database db, int version){
//     return db.query(
//       '''
//       CREATE TABLE $_tableName (
//       $columnId INTEGER PRIMARY KEY,
//       $columnName TEXT NOT NULL,
//       $columnDescription TEXT )
//       '''
//     );
//   }
//
//   Future<int> insert(Map<String, dynamic> row) async {
//     Database db = await instance.database;
//     return await db.insert(_tableName, row);
//   }
//
//   Future<List<Map<String, dynamic>>>  queryAll() async{
//     Database db = await instance.database;
//     return await db.query(_tableName);
//   }
//
//   Future update (Map<String, dynamic> row)async{
//     Database db = await instance.database;
//     int id = row[columnId];
//     return await db.update(_tableName, row,where: '$columnId = ?', whereArgs: [id]);
//   }
//
//   Future<int> delete(int id)async{
//     Database db = await instance.database;
//     return await db.delete(_tableName,where: '$columnId = ?', whereArgs: [id]);
//   }
//
//   Future save(table, data) async {
//     Database db = await instance.database;
//     return await db.insert(_tableName, data);
//   }
//
//   getAll(table) async{
//     Database db = await instance.database;
//     return await db.query(_tableName);
//   }
//
//
//
// }
