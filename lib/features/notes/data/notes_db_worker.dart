import 'package:path/path.dart';
import 'package:pim_book/features/notes/domain/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:pim_book/core/utils.dart' as utils;

class NotesDBWorker{

  NotesDBWorker._(){
    database;
  }
  static final instance = NotesDBWorker._();

  Database? _db;
  Future get database async {
    if (_db == null) {
      _db = await init();
    }
    return _db;
  }

  Future<Database> init() async{
    String path = join(utils.docsDir!.path,"notes.db");
    Database db = await openDatabase(path,
        version: 1,
        onOpen: (db){},
      onCreate: (Database inDB,int inVersion)async{
      await inDB.execute("CREATE TABLE IF NOT EXISTS notes("
        "id INTEGER PRIMARY KEY,"
        "title TEXT,"
        "content TEXT,"
        "color TEXT"
        ")"
      );
      }
    );
    return db;
  }
  
  Future create(Note inNote)async{
    Database db = await database;
    var val = await db.rawQuery("SELECT MAX(id) + 1 AS id FROM notes");
    int? id = val.first["id"] as int?;
    if (id == null) {
      id = 1;
    }
    return await db.rawInsert(
        "INSERT INTO notes (id,title,content,color) VALUES(?,?,?,?)",
        [id,inNote.title,inNote.content,inNote.color]
    );

  }

  Future<Note> get(int inId)async{
    Database db = await database;
    var rec = await db.query("notes",where: "id = ?",whereArgs: [inId]);
    return Note.fromMap(rec.first);
  }

  Future<List> getAll()async{
    Database db =await database;
    var recs = await db.query("notes");
    var list = recs.isNotEmpty ? recs.map((e) => Note.fromMap(e)).toList() : [];
    return list;
  }

  Future update(Note inNote)async{
    Database db = await database;
    return await db.update("notes", Note.toMap(inNote),where: "id = ?",whereArgs: [inNote.id]);
  }

  Future delete(int inId)async{
    Database db = await database;
    return await db.delete("notes",where: "id = ?",whereArgs: [inId]);
  }
}