import 'package:pim_book/features/notes/domain/note.dart';
import 'package:sqflite/sqflite.dart';
import '../../../core/data/pim_db.dart';
import '../domain/notes_repository.dart';

class NotesDBWorker implements NotesRepository {

  Database? _cachedDb; // Cache the database instance after successful initialization

  Future<Database> _initializeDatabase() async {
    final result = await PIMdb.instance.init();
    return result.fold(
          (failure) {
        //TODO Handle the failure (e.g., show an error message, log, etc.)
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
  Future<int> create(Note note) async {
    final db = await _database;
    var val = await db.rawQuery("SELECT MAX(id) + 1 AS id FROM notes");
    int? id = val.first["id"] as int?;
    if (id == null) {
      id = 1;
    }
    /// update the id
    note.id = id;
    return await db.insert('notes', note.toMap());
  }

  @override
  Future<Note> get(int id) async {
    final db = await _database;
    final maps = await db.query('notes', where: 'id = ?', whereArgs: [id]);
    return Note.fromMap(maps.first);
  }

  @override
  Future<int> update(Note note) async {
    final db = await _database;
    return await db.update('notes', note.toMap(), where: 'id = ?', whereArgs: [note.id]);
  }

  @override
  Future<int> delete(int id) async {
    final db = await _database;
    return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<List<Note>> getAllDescendants() async {
    final db = await _database;
    final maps = await db.query('notes', orderBy: 'dateEdited DESC');
    return List.generate(maps.length, (index) => Note.fromMap(maps[index]));
  }

  // Implement other methods as needed

  @override
  Future<List<Note>> getAllAscendants() {
    // TODO: implement getAllAscendants
    throw UnimplementedError();
  }

}