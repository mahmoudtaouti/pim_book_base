
import 'package:pim_book/core/base_model.dart';
import 'package:pim_book/features/notes/domain/note.dart';

NotesModel notesModel =  NotesModel();

class NotesModel extends BaseModel{

  NotesModel(){
    entityBeingEdited = Note();
  }

  String? _color;
  set color(String? inColor){
    _color = inColor;
    notifyListeners();
  }
  String? get color => _color;

}