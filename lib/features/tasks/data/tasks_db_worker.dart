import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pim_book/features/tasks/data/tasks_helper.dart';
import 'package:pim_book/features/tasks/domain/task.dart';
import 'package:sqflite/sqflite.dart';
import 'package:pim_book/core/utils.dart' as utils;



class TasksDBWorker{

  TasksDBWorker._(){
    database;
  }
  static final instance = TasksDBWorker._();

  Database? _db;
  Future get database async {
    if (_db == null) {
      _db = await init();
    }
    return _db;
  }

  Future<Database> init() async{
    Directory docsDir = await getApplicationDocumentsDirectory();
    String path = join(docsDir.path,"tasks.db");
    Database db = await openDatabase(path,
        version: 1,
        onOpen: (db){},
        onCreate: (Database inDB,int inVersion)async{
          await inDB.execute("CREATE TABLE IF NOT EXISTS tasks("
              "id INTEGER PRIMARY KEY,"
              "description TEXT,"
              "dueDate TEXT,"
              "completed TEXT"
              ")"
          );
        }
    );
    return db;
  }

  Future create(Task inTask)async{
    Database db = await database;
    var val = await db.rawQuery("SELECT MAX(id) + 1 AS id FROM tasks");
    int? id = val.first["id"] as int?;
    if (id == null) {
      id = 1;
    }
    return await db.rawInsert(
        "INSERT INTO tasks (id,description,dueDate,completed) VALUES(?,?,?,?)",
        [id,inTask.description,inTask.dueDate,inTask.completed]
    );

  }

  Future<Task> get(int inId)async{
    Database db = await database;
    var rec = await db.query("tasks",where: "id = ?",whereArgs: [inId]);
    return Task.fromMap(rec.first);
  }

  Future<List> getAll()async{
    Database db =await database;
    var recs = await db.query("tasks");
    var list = recs.isNotEmpty ? recs.map((e) => Task.fromMap(e)).toList() : [];
    return list;
  }

  Future update(Task inTask)async{
    Database db = await database;
    return await db.update("tasks", Task.toMap(inTask),where: "id = ?",whereArgs: [inTask.id]);
  }

  Future delete(int inId)async{
    Database db = await database;
    return await db.delete("tasks",where: "id = ?",whereArgs: [inId]);
  }
}