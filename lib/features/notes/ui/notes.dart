import 'package:flutter/material.dart';
import 'package:pim_book/features/notes/domain/notes_model.dart';
import 'package:pim_book/features/notes/ui/notes_entry.dart';
import 'package:pim_book/features/notes/ui/notes_list.dart';
import 'package:provider/provider.dart';

class Notes extends StatefulWidget {

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    return  IndexedStack(
      index: Provider.of<NotesModel>(context).stackIndex,
      children: [
        NotesList(),
        NotesEntry()
      ],
    );
  }
}
