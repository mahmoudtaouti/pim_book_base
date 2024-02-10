import 'note.dart';

abstract class NotesRepository{

  Future<int> create(Note note);
  Future<Note> get(int id);
  Future<int> update(Note note);
  Future<int> delete(int id);

  Future<List<Note>> getAllDescendants(); // By edited time
  Future<List<Note>> getAllAscendants(); // By edited time
}