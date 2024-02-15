import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../application/notes_ctrl.dart';
import '../domain/note.dart';
import 'component/note_card.dart';

class NotesListPage extends StatelessWidget {
  final NotesController ctrl = Get.find<NotesController>();

  NotesListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        child: Wrap(
          children: ctrl.notes.map((element) {
            return _buildNoteCard(context, element);
          }).toList()),
        ),
      );
  }

  Widget _buildNoteCard(BuildContext context, Note note) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      child: NoteCard(
        note: note,
        ctrl: ctrl,
      ),
    );
  }
}
