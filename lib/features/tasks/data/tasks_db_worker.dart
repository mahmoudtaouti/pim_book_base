
import 'package:pim_book/features/tasks/domain/task.dart';
import 'package:pim_book/features/tasks/domain/tasks_repository.dart';
import 'package:sqflite/sqflite.dart';
import '../../../core/data/pim_db.dart';


class TasksDBWorker  implements TasksRepository{

  Database? _cachedDb; // Cache the database instance after successful initialization

  Future<Database> _initializeDatabase() async {
    final result = await PIMdb.instance.init();
    return result.fold(
          (failure) {
        // Handle the failure (e.g., show an error message, log, etc.)
        throw Exception("Failed to initialize database: $failure");
      },
          (db) {
        // Cache the database instance
        _cachedDb = db;
        return db;
      },
    );
  }

  Future<Database> get _database async {
    return _cachedDb ?? await _initializeDatabase();
  }

  @override
  Future<int> createTask(Task task) async {
    final db = await _database;
    var val = await db.rawQuery("SELECT MAX(id) + 1 AS id FROM tasks");
    int? id = val.first["id"] as int?;
    if (id == null) {
      id = 1;
    }
    /// update the id
    task.id = id;
    return await db.insert('tasks', task.toMap());
  }

  @override
  Future<int> createGroup(GroupTask groupTask) async {
    final db = await _database;
    var val = await db.rawQuery("SELECT MAX(id) + 1 AS id FROM group_tasks");
    int? id = val.first["id"] as int?;
    if (id == null) {
      id = 1;
    }
    /// update the id
    groupTask.id = id;
    return await db.insert('group_tasks', groupTask.toMap());
  }

  @override
  Future<Task> getTask(int id) async {
    final db = await _database;
    final maps = await db.query('tasks', where: 'id = ?', whereArgs: [id]);
    return Task.fromMap(maps.first);
  }

  @override
  Future<GroupTask> getGroup(int id) async {
    final db = await _database;
    final result = await db.query('group_tasks', where: 'id = ?', whereArgs: [id]);
    return GroupTask.fromMap(result.first);
  }

  @override
  Future<int> updateTask(Task task) async {
    final db = await _database;
    return await db.update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }

  @override
  Future<int> updateGroup(GroupTask groupTask) async {
    final db = await _database;
    return db.update('group_tasks', groupTask.toMap(), where: 'id = ?', whereArgs: [groupTask.id]);
  }

  @override
  Future<int> deleteTask(int id) async {
    final db = await _database;
    return await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<int> deleteGroup(int id) async {
    final db = await _database;
    return db.delete('group_tasks', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<List<Task>> getOnlyTasks() async {
    final db = await _database;
    final maps = await db.query('tasks', orderBy: 'dateCreated DESC');
    return List.generate(maps.length, (index) => Task.fromMap(maps[index]));
  }

  @override
  Future<List<GroupTask>> getOnlyGroups() async {
    final db = await _database;
    final result = await db.query('group_tasks', orderBy: 'dateCreated DESC');
    return result.map((e) => GroupTask.fromMap(e)).toList();
  }


  @override
  Future<List<dynamic>> getAll() async {
    final db = await _database;
    final tasks = await db.query('tasks', orderBy: 'dateCreated DESC');
    final groupTasks = await db.query('group_tasks', orderBy: 'dateCreated DESC');
    final allTasks = <Task>[];
    final allGroupTasks = <GroupTask>[];

    for (final task in tasks) {
      allTasks.add(Task.fromMap(task));
    }

    for (final groupTask in groupTasks) {
      allGroupTasks.add(GroupTask.fromMap(groupTask));
    }

    final all = <dynamic>[];
    all.addAll(allTasks);
    all.addAll(allGroupTasks);
    all.sort((a, b) => b.dateCreated.compareTo(a.dateCreated));

    return all;
  }



  @override
  Future<List<dynamic>> getAllChecked() {
    // TODO: implement getAllChecked
    throw UnimplementedError();
  }

  @override
  Future<List<dynamic>> getAllDueDate() {
    // TODO: implement getAllDueDate
    throw UnimplementedError();
  }

  @override
  Future<List<dynamic>> getAllUnchecked() {
    // TODO: implement getAllUnchecked
    throw UnimplementedError();
  }



}
