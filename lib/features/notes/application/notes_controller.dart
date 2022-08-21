import 'package:get/get.dart';
import 'package:pim_book/features/notes/data/notes_db_worker.dart';
import 'package:pim_book/features/notes/domain/note.dart';
import 'package:pim_book/features/notes/ui/notes_entry.dart';

class NotesController extends GetxController{

  var notesList = [].obs;

  //TODO delete it if no need
  var noteBeingEdited = Note.set("","","grey");

  NotesController(){
    _updateListData();
  }

  _updateListData() async {
    notesList.value = await NotesDBWorker().getAll();
  }

  onNewNotePressed() async {
    noteBeingEdited = Note.set("", "", "grey");
    //todo solve duplicated call _updateListData()
    await Get.to(()=> NotesEntry(noteBeingEdited))!.whenComplete(() => _updateListData());
    _updateListData();
  }

  onSelectNote(Note note) async{
    noteBeingEdited = await NotesDBWorker().getNote(note.id!);
    Get.to(()=> NotesEntry(noteBeingEdited))!.whenComplete(() => _updateListData());
  }

  onDeleteNote(int noteId)async{
    await NotesDBWorker().delete(noteId);
    await _updateListData();
  }

}