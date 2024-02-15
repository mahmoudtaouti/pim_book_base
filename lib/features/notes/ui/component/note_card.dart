import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pim_book/core/component/color_pallet_Component.dart';

import '../../../../core/utils.dart';
import '../../application/notes_ctrl.dart';
import '../../domain/note.dart';
import '../note_content_screen.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final NotesController ctrl;
  NoteCard({required this.note, required this.ctrl});

  @override
  Widget build(BuildContext context) {
    QuillController quillController = QuillController.basic();
    List<dynamic> contentData =  json.decode(note.content);
    quillController.document = Document.fromDelta(Delta.fromJson(contentData));

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Get.isDarkMode ? CardColor.getDarkerColorOf(Utils.colorFromString(note.color)) : Utils.colorFromString(note.color),
        border: Border.fromBorderSide(BorderSide(color: Colors.grey.shade400, width: 0.5)),
      ),
      child: InkWell(
        onTap: (){
          Get.to(() => NoteContentScreen(note: note,));
        },
        onLongPress: (){
          _showDeleteTaskBottomSheet(context);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            note.title.isNotEmpty ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                note.title,
                style: Get.textTheme.headlineMedium,
              ),
            ) : SizedBox.shrink(),
            !quillController.document.isEmpty() ? Container(
              padding: EdgeInsets.all(14),
              constraints: BoxConstraints(
                maxHeight: 500,
              ),
              child: ClipRect(
                child: QuillEditor.basic(
                  configurations: QuillEditorConfigurations(
                    controller: quillController,
                    scrollable: false,
                    readOnly: true,
                    expands: false,
                    showCursor: false,
                    enableInteractiveSelection: false,
                    enableSelectionToolbar: false,
                    isOnTapOutsideEnabled: false,
                    sharedConfigurations: const QuillSharedConfigurations(
                      locale: Locale('en'),
                    ),
                  ),
                ),
              ),
            ) : SizedBox(width: Get.width,),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Edited: ${DateFormat.yMMMd().format(DateTime.fromMillisecondsSinceEpoch(note.dateEdited))}',
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteTaskBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          width: Get.width,
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Delete Note',
                style: Get.textTheme.headlineMedium,
              ),
              SizedBox(height: 16),
              Text(
                note.title,
                style: Get.textTheme.titleMedium,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Get.back(); // Close the BottomSheet
                  // Perform the delete operation here
                  ctrl.deleteThisNote(note);
                },
                child: Text('Delete'),
              ),
            ],
          ),
        );
      },
    );
  }
}
