import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pim_book/features/notes/data/notes_db_worker.dart';
import 'package:pim_book/features/notes/domain/note.dart';

class NotesEntryController extends GetxController{

  Note note;
  var color = "grey".obs;

  late TextEditingController titleTextEditingController;
  late TextEditingController contentTextEditingController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  NotesEntryController({required this.note}){
    /// add listener to textField when ever the data changes
    /// we pass it to entity being edited
    titleTextEditingController = TextEditingController();
    contentTextEditingController= TextEditingController();

    titleTextEditingController.addListener(() {
      note.title = titleTextEditingController.text;
    });
    contentTextEditingController.addListener(() {
      note.content = contentTextEditingController.text;
    });

    /// case we entity being edited exist and we just wont to update it
    /// if entity being edited is a new note the title and content length is 0
    titleTextEditingController.text = note.title;
    contentTextEditingController.text = note.content;

  }


  onSaveNote()async{

    if (note.id == null)  {
      await NotesDBWorker().create(note);
    } else{
      await NotesDBWorker().update(note);
    }
    Get.back();
    //TODO update the list after saving
  }

  onSelectColor(String colorTxt){
    color.value = colorTxt;
    note.color = colorTxt;
  }

}