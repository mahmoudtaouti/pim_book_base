import 'package:pim_book/features/events/domain/pim_event.dart';
import 'package:sqflite/sqflite.dart';
import '../../../core/Database.dart';

class EventsDBWorker{

  EventsDBWorker(){
    database;
  }

  Database? _database;

  Future get database async {
    _database = await PIM_DB.instance.database;
    return _database;
  }


  Future create(PIMEvent event)async{
    Database db = await database;
    var val = await db.rawQuery("SELECT MAX(id) + 1 AS id FROM events");
    int? id = val.first["id"] as int?;
    if (id == null) {
      id = 1;
    }
    return await db.rawInsert(
        "INSERT INTO events (id,title,description,startDate,endDate,color) VALUES(?,?,?,?,?)",
        [id,event.title,event.description,event.startDate,event.endDate,event.color]
    );

  }

  Future<PIMEvent> get(int inId)async{
    Database db = await database;
    var rec = await db.query("events",where: "id = ?",whereArgs: [inId]);
    return PIMEvent.fromMap(rec.first);
  }

  Future<List> getAll()async{
    Database db =await database;
    var recs = await db.query("events");
    var list = recs.isNotEmpty ? recs.map((e) => PIMEvent.fromMap(e)).toList() : [];
    return list;
  }

  Future update(PIMEvent inNote)async{
    Database db = await database;
    return await db.update("events", PIMEvent.toMap(inNote),where: "id = ?",whereArgs: [inNote.id]);
  }

  Future delete(int inId)async{
    Database db = await database;
    return await db.delete("events",where: "id = ?",whereArgs: [inId]);
  }
}