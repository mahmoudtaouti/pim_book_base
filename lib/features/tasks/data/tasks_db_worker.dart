import 'dart:io';

import 'package:path/path.dart';
import 'package:pim_book/features/tasks/domain/i_tasks_facade.dart';
import 'package:pim_book/features/tasks/domain/task.dart';
import 'package:sqflite/sqflite.dart';
import 'package:pim_book/core/utils.dart' as utils;

import '../../../core/Database.dart';



class TasksDBWorker implements ITasksFacade{

  TasksDBWorker(){
    database;
  }

  Database? _database;

  Future get database async {
    _database = await PIM_DB.instance.database;
    return _database;
  }


  @override
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

  @override
  Future<Task> getTask(int inId)async{
    Database db = await database;
    var rec = await db.query("tasks",where: "id = ?",whereArgs: [inId]);
    return Task.fromMap(rec.first);
  }

  @override
  Future<List> getAll()async{
    Database db = await database;
    var recs = await db.query("tasks");
    var list = recs.isNotEmpty ? recs.map((e) => Task.fromMap(e)).toList() : [];
    return list;
  }

  @override
  Future update(Task inTask)async{
    Database db = await database;
    return await db.update("tasks", Task.toMap(inTask),where: "id = ?",whereArgs: [inTask.id]);
  }

  @override
  Future delete(int inId)async{
    Database db = await database;
    return await db.delete("tasks",where: "id = ?",whereArgs: [inId]);
  }
}