
import 'package:sqflite/sqflite.dart';

import '../../../core/data/pim_db.dart';
import '../domain/reminder.dart';
import '../domain/reminders_repository.dart';


class RemindersDBWorker extends RemindersRepository {

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
  Future<int> create(Reminder reminder) async {
    final db = await _database;
    var val = await db.rawQuery("SELECT MAX(id) + 1 AS id FROM reminders");
    int? id = val.first["id"] as int?;
    if (id == null) {
      id = 1;
    }
    /// update the id
    reminder.id = id;
    return await db.insert('reminders', Reminder.toMap(reminder));
  }


  @override
  Future<Reminder> get(int id) async {
    final db = await _database;
    final maps = await db.query('reminders', where: 'id = ?', whereArgs: [id]);
    return Reminder.fromMap(maps.first);
  }

  @override
  Future<int> update(Reminder reminder) async {
    final db = await _database;
    return await db.update('reminders', Reminder.toMap(reminder), where: 'id = ?', whereArgs: [reminder.id]);
  }

  @override
  Future<int> delete(int id) async {
    final db = await _database;
    return await db.delete('reminders', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<List<Reminder>> getAllDescendant() async {
    final db = await _database;
    final maps = await db.query('reminders', orderBy: 'time ASC'); // or use 'date DESC, time DESC'
    return List.generate(maps.length, (index) => Reminder.fromMap(maps[index]));
  }

}
