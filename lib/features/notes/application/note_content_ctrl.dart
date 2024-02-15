import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:pim_book/features/notes/application/notes_ctrl.dart';
import 'package:pim_book/features/notes/data/notes_db_worker.dart';
import '../../../core/utils.dart';
import '../domain/note.dart';
import 'dart:convert';

class NoteContentCTRL extends GetxController {
  NotesDBWorker notesDBWorker = NotesDBWorker();

  QuillController richTextCtrl = QuillController.basic();
  final titleController = TextEditingController();
  var _selectedColor = Utils.colorToString(Colors.transparent).obs;
  var colorPalletButtonKey = GlobalKey();
  Note? _noteData;

  NoteContentCTRL({Note? noteData}) : _noteData = noteData {
    if (_noteData != null) {
      _loadNote();
    }
  }

  @override
  void onInit() {
    // richTextCtrl.document.changes.listen((event) {
    //   this._updateNote();
    // });
    super.onInit();
  }

  Color get noteColor => Utils.colorFromString(_selectedColor.value);

  Color? get scaffoldBackgroundColor {
    if (_selectedColor.value != Utils.colorToString(Colors.transparent)) {
      Color tColor = Utils.colorFromString(_selectedColor.value);
      if (Get.isDarkMode) {
        return tColor.withOpacity(0.3);
      } else {
        return tColor;
      }
    }
    return null;
  }

  setNoteColor(Color color) {
    _selectedColor.value = Utils.colorToString(color);
  }

  DateTime get editedDate {
    if (_noteData != null) {
      return DateTime.fromMillisecondsSinceEpoch(_noteData!.dateEdited);
    } else {
      return DateTime.now();
    }
  }

  /// to clear the editor
  void clearEditor() => richTextCtrl.clear();

  @override
  void dispose() async {
    await _updateNote();
    final notesCtrl = Get.find<NotesController>();
    notesCtrl.fetchNotes();
    richTextCtrl.document.changes.drain();
    richTextCtrl.dispose();
    titleController.dispose();
    super.dispose();
  }

  Future<void> _updateNote() async {
    int timeNow = DateTime.now().millisecondsSinceEpoch;
    String title = titleController.text;
    String content = jsonEncode(richTextCtrl.document.toDelta());
    String color = _selectedColor.value;
    int dateCreated = _noteData != null ? _noteData!.dateCreated : timeNow;
    int dateEdited = timeNow;

    if (this._noteData == null) {
      this._noteData = Note(
          title: title,
          content: content,
          color: color,
          dateCreated: dateCreated,
          dateEdited: dateEdited);
      if (this._noteData!.isValid().isRight() ||
          !richTextCtrl.document.isEmpty()) {
        await notesDBWorker.create(this._noteData!);
      }
    } else {
      await notesDBWorker.update(this._noteData!.updateData(
          title: title,
          content: content,
          color: color,
          dateEdited: dateEdited));
    }
  }

  _loadNote() async {
    titleController.text = this._noteData!.title;
    richTextCtrl.document =
        Document.fromJson(json.decode(this._noteData!.content));
    _selectedColor.value = this._noteData!.color;
  }

  saveNote() async {
    _updateNote();
    Get.back();
  }
}
