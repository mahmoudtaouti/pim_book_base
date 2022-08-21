import 'note.dart';

abstract class INotesFacade{
  Future<Note> getNote(int id);
  Future<List> getAll();//no Data failure
  Future create(Note inNote);
  Future update(Note inNote);
  Future delete(int inId);
  // Future createBackup(); TODO save locale backup
  // Future syncDataFromServer();
}