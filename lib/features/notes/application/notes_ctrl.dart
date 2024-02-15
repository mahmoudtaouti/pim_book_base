import 'package:pim_book/features/notes/data/notes_db_worker.dart';

import '../domain/note.dart';
import 'package:get/get.dart';

class NotesController extends GetxController {
  var _notes = <Note>[].obs;
  NotesDBWorker notesDBWorker = NotesDBWorker();


  onInit(){
    fetchNotes();
    super.onInit();
  }

  List<Note> get notes => _notes;

  Future<void> fetchNotes() async {
    try {
      final fetchedNotes = await notesDBWorker.getAllDescendants();
      _notes.value = fetchedNotes;
      update();
    } catch (e) {
      print('Error fetching notes: $e');
    }
  }

  void deleteThisNote(Note note) async {
    _notes.remove(note);
    await notesDBWorker.delete(note.id!);
    update();
    Get.showSnackbar(GetSnackBar(title: 'Note Deleted',message: 'Note: ${note.title}',duration: Duration(seconds: 1),));
  }
}