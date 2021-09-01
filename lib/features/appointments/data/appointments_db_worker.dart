import 'package:path/path.dart';
import 'package:pim_book/features/appointments/domain/appointment.dart';
import 'package:sqflite/sqflite.dart';
import 'package:pim_book/core/utils.dart' as utils;

class AppointmentsDBWorker{

  AppointmentsDBWorker._(){
    database;
  }
  static final instance = AppointmentsDBWorker._();

  Database? _db;
  Future get database async {
    if (_db == null) {
      _db = await init();
    }
    return _db;
  }

  Future<Database> init() async{
    String path = join(utils.docsDir!.path,"appointments.db");
    Database db = await openDatabase(path,
        version: 1,
        onOpen: (db){},
        onCreate: (Database inDB,int inVersion)async{
          await inDB.execute("CREATE TABLE IF NOT EXISTS appointments("
              "id INTEGER PRIMARY KEY,"
              "title TEXT,"
              "description TEXT,"
              "apptDate TEXT,"
              "apptTime TEXT"
              ")"
          );
        }
    );
    return db;
  }

  Future create(Appointment appointment)async{
    Database db = await database;
    var val = await db.rawQuery("SELECT MAX(id) + 1 AS id FROM appointments");
    int? id = val.first["id"] as int?;
    if (id == null) {
      id = 1;
    }
    return await db.rawInsert(
        "INSERT INTO appointments (id,title,description,apptDate,apptTime) VALUES(?,?,?,?,?)",
        [id,appointment.title,appointment.description,appointment.apptDate,appointment.apptTime]
    );

  }

  Future<Appointment> get(int inId)async{
    Database db = await database;
    var rec = await db.query("appointments",where: "id = ?",whereArgs: [inId]);
    return Appointment.fromMap(rec.first);
  }

  Future<List> getAll()async{
    Database db =await database;
    var recs = await db.query("appointments");
    var list = recs.isNotEmpty ? recs.map((e) => Appointment.fromMap(e)).toList() : [];
    return list;
  }

  Future update(Appointment inNote)async{
    Database db = await database;
    return await db.update("appointments", Appointment.toMap(inNote),where: "id = ?",whereArgs: [inNote.id]);
  }

  Future delete(int inId)async{
    Database db = await database;
    return await db.delete("appointments",where: "id = ?",whereArgs: [inId]);
  }
}