import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pim_book/features/notes/ui/note_content_screen.dart';
import 'package:pim_book/features/notes/ui/notes_list.dart';

import '../../../core/theme/pim_icons.dart';

class Notes extends StatefulWidget {

  const Notes({Key? key}) : super(key: key);
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'new_note',
        onPressed: () => Get.to(
            () => NoteContentScreen(),
          transition: Transition.downToUp, // Specify the transition animation
          duration: Duration(milliseconds: 500),
          curve: Curves.easeIn,
        ), // Set animation duration),
        label: Text('Note'),
        icon: PIMIcons.fromAsset(
            iconName: PIMIcons.add_square,
            color:Get.theme.iconTheme.color!),
      ),
      body: NotesListPage(),
    );
  }
}
