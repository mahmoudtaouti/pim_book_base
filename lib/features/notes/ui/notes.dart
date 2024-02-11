import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pim_book/features/notes/ui/note_content_screen.dart';

import '../../../core/theme/pim_icons.dart';
class Notes extends StatefulWidget {

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton:           FloatingActionButton.extended(
        onPressed: ()=> Get.to(NoteContentScreen()),
        label: Text('New Note'),
        icon: PIMIcons.fromAsset(iconName: PIMIcons.document_text,color: Get.theme.colorScheme.onInverseSurface),
      ),
      body: Placeholder(),
    );
  }
}
