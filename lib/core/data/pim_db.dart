import 'package:dartz/dartz.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:pim_book/core/utils.dart' as utils;
import 'package:sqflite/sqflite.dart';
import '../domain/failures.dart';

class PIMdb {
  PIMdb._();

  static final PIMdb _instance = PIMdb._();

  static PIMdb get instance => _instance;

  Database? _db;

  Future<Either<DatabaseFailure, Database>> get database async {
    if (_db == null) {
      return await init();
    }
    return Right(_db!);
  }

  Future<Either<DatabaseFailure, Database>> init() async {
    try {
      Directory docsDir = await utils.Utils.docsDir;

      String path = join(docsDir.path, "pim.db");

      //TODO: Check for insufficient storage space
      // if (!(await checkStorageSpace())) {
      //   return Left(const DatabaseFailure.insufficientStorageSpace());
      // }

      Database db = await openDatabase(path,
          version: 1,
          onOpen: (db) {},
          onCreate: (Database inDB, int inVersion) async {
            await inDB.execute("CREATE TABLE IF NOT EXISTS notes("
                "id INTEGER PRIMARY KEY,"
                "title TEXT,"
                "content TEXT,"
                "color TEXT,"
                "dateCreated INTEGER,"
                "dateEdited INTEGER"
                ")"
            );
            await inDB.execute("CREATE TABLE IF NOT EXISTS tasks("
                "id INTEGER PRIMARY KEY,"
                "title TEXT,"
                "dueDate INTEGER,"
                "checked INTEGER,"
                "dateCreated INTEGER,"
                "dateEdited INTEGER"
                ")"
            );
            await inDB.execute("CREATE TABLE IF NOT EXISTS group_tasks("
                "id INTEGER PRIMARY KEY,"
                "title TEXT,"
                "tasks TEXT,"
                "dueDate INTEGER,"
                "checked INTEGER,"
                "dateCreated INTEGER,"
                "dateEdited INTEGER"
                ")"
            );
            await inDB.execute("CREATE TABLE IF NOT EXISTS reminders("
                "id INTEGER PRIMARY KEY,"
                "title TEXT,"
                "description TEXT,"
                "date INTEGER,"
                "time INTEGER,"
                "color TEXT,"
                "duration INTEGER,"
                "dateCreated INTEGER,"
                "dateEdited INTEGER"
                ")"
            );
          });

      _db = db;
      return Right(db);
    } on FileSystemException {
      // Handle permission denied error
      return Left(const DatabaseFailure.permissionDenied());
    } catch (e) {
      // Handle other errors
      return Left(const DatabaseFailure.notFound());
    }
  }






}




//TODO: implement Backup feature
// Future<void> backupDatabase() async {
//   try {
//     Directory? backupDir = await getExternalStorageDirectory();
//     String backupPath = join(backupDir!.path, "PIM Book", "pim_backup.db");
//
//     // Copy the database file to the backup location
//     await File(join(backupDir.path, "pim.db")).copy(backupPath);
//
//     // Optionally, you can include additional logic here, such as notifying the user about the backup completion.
//     print("Backup completed successfully. Backup file path: $backupPath");
//   } catch (e) {
//     print("Error during backup: $e");
//   }
// }

// void shareFile(File localFile) {
//   Share.shareFiles([localFile.path], text: 'Sharing pim.db');
// }