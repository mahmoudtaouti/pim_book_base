// ignore_for_file: camel_case_types

import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:pim_book/core/utils.dart';
import 'dart:convert' as convert;
import 'package:encrypt/encrypt.dart' as encrypt ;



class PIM_DB{

  PIM_DB._(){
    database;
  }

  static final instance = PIM_DB._();

  Database? _db;

  Future get database async {
    if (_db == null) {
      _db = await init();
    }
    return _db;
  }

  Future<Database> init() async{
    Directory docsDir = await Utils.docsDir;
    String path = join(docsDir.path,"PIM_DB.db");
    Database db = await openDatabase(path,
        version: 1,
        onOpen: (db){},
        onCreate: (Database inDB,int inVersion)async{

      //current 3 services is working

          await inDB.execute("CREATE TABLE IF NOT EXISTS notes("
              "id INTEGER PRIMARY KEY,"
              "title TEXT,"
              "content TEXT,"
              "color TEXT"
              ")"
          );

          await inDB.execute("CREATE TABLE IF NOT EXISTS tasks("
              "id INTEGER PRIMARY KEY,"
              "description TEXT,"
              "dueDate TEXT,"
              "completed TEXT"
              ")"
          );

          await inDB.execute("CREATE TABLE IF NOT EXISTS events("
              "id INTEGER PRIMARY KEY,"
              "title TEXT,"
              "description TEXT,"
              "startDate TEXT,"
              "endDate TEXT,"
              "color INTEGER"
              ")"
          );


        }
    );
    return db;
  }



  List<String> tables =['notes','tasks','events'];
  static const SECRET_KEY = "2Ea5aWVa7ycSC7Em";

  Future<String>generateBackup({bool isEncrypted = true}) async {


    Directory dir = await Utils.extDir;
    String path = dir.path  + '/' + 'backup.pim';

    File bk = await File(path).create(recursive: true);

    String string;
    print('GENERATE BACKUP');

    var dbs = await this.database;

    List data =[];

    List<Map<String,dynamic>> listMaps=[];

    for (var i = 0; i < tables.length; i++)
    {

      listMaps = await dbs.query(tables[i]);

      data.add(listMaps);

    }

    List backups=[tables,data];

    String json = convert.jsonEncode(backups);

    if(isEncrypted)
    {

      var key = encrypt.Key.fromUtf8(SECRET_KEY);
      var iv = encrypt.IV.fromLength(16);
      var encrypter = encrypt.Encrypter(encrypt.AES(key)) ;
      var encrypted = encrypter.encrypt(json, iv: iv);

      string =  encrypted.base64;
    }
    else
    {
      string = json;
    }
    bk.writeAsString(string);
    print(path);
    return path;
  }

  Future<void>restoreBackup({ bool isEncrypted = true}) async {

    var dbs = await this.database;

    Directory dir = await Utils.extDir;
    String path = dir.path + '/' + 'backup.pim';
    File bk = File(path);
    if(bk.existsSync()){
      String backup;
      try {
        backup = await  bk.readAsString();
        Batch batch = dbs.batch();

        var key = encrypt.Key.fromUtf8(SECRET_KEY);
        var iv = encrypt.IV.fromLength(16);
        var encrypter = encrypt.Encrypter(encrypt.AES(key));

        List json = convert.jsonDecode(isEncrypted ? encrypter.decrypt64(backup,iv:iv):backup);

        for (var i = 0; i < json[0].length; i++)
        {
          for (var k = 0; k < json[1][i].length; k++)
          {
            batch.insert(json[0][i],json[1][i][k]);
          }
        }

        await batch.commit(continueOnError:false,noResult:true);

        print('RESTORE BACKUP');
      }catch(e){

      }
    }



  }

  Future clearAllTables() async {
    try
    {
      var dbs = await this.database;
      for (String table  in tables)
      {
        await dbs.delete(table);
        await dbs.rawQuery("DELETE FROM $table");
      }

      print('------ CLEAR ALL TABLE');
    }
    catch(e){}
  }

}