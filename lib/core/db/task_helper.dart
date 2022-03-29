import 'dart:async';

import 'package:myalarm/feature/data/model/task_model.dart';
import 'package:myalarm/feature/domain/entities/task_entity.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

const String tableTask = 'task';
const String columnId = 'id';
const String columnTitle = 'title';
const String columnDateTime = 'dateTime';
const String columnStartTime = 'startTime';
const String columnEndTime = 'endTime';

class TaskHelper {
  static final TaskHelper instance = TaskHelper._init();

  static Database? _database;

  TaskHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('task.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";

    await db.execute('''
        create table $tableTask (
          $columnId $idType,
          $columnTitle $textType,
          $columnDateTime $textType,
          $columnStartTime $textType,
          $columnEndTime $textType
          )
      ''');
  }

  void insertTask(TaskEntity taskModel) async {
    var db = await database;
    var result = await db.insert(tableTask, taskModel.toMap());
    print('result : $result');
  }

  Future<List<TaskModel>> selectAllData() async {
    var db = await database;
    var result = await db.rawQuery('SELECT * FROM $tableTask');
    return result.map((json) => TaskModel.fromJson(json)).toList();
  }
}
