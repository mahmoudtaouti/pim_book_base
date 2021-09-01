import 'package:flutter/material.dart';
import 'package:pim_book/features/notes/domain/notes_model.dart' show NotesModel, notesModel;
import 'package:pim_book/features/notes/ui/notes_entry.dart';
import 'package:pim_book/features/notes/ui/notes_list.dart';
import 'package:scoped_model/scoped_model.dart';

// class Notes extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return ScopedModel<NotesModel>(
//         model: notesModel,
//         child: ScopedModelDescendant<NotesModel>(
//           builder: (BuildContext context,Widget? child,NotesModel model)=>
//           IndexedStack(
//             index: model.stackIndex,
//             children: [
//               NotesList(),
//               NotesEntry()
//             ],
//           ),
//         ));
//   }
// }
