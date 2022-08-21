import 'package:pim_book/core/Database.dart';
import 'package:pim_book/features/notes/domain/i_notes_facade.dart';
import 'package:pim_book/features/notes/domain/note.dart';
import 'package:sqflite/sqflite.dart';


class NotesDBWorker implements INotesFacade {

  NotesDBWorker(){
    database;
  }

  Database? _database;

  Future get database async {
    _database = await PIM_DB.instance.database;
    return _database;
  }


  @override
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

  @override
  Future<Note> getNote(int inId)async{
    Database db = await database;
    var rec = await db.query("notes",where: "id = ?",whereArgs: [inId]);
    return Note.fromMap(rec.first);
  }

  @override
  Future<List> getAll()async{
    Database db = await database;
    var recs = await db.query("notes");
    return  recs.isNotEmpty ? recs.map((e) => Note.fromMap(e)).toList() : [];
  }

  @override
  Future update(Note inNote)async{
    Database db = await database;
    return await db.update("notes", Note.toMap(inNote),where: "id = ?",whereArgs: [inNote.id]);
  }

  @override
  Future delete(int inId)async{
    Database db = await database;
    return await db.delete("notes",where: "id = ?",whereArgs: [inId]);
  }



}