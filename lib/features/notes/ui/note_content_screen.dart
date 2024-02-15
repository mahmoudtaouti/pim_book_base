import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pim_book/core/theme/pim_icons.dart';
import '../../../core/component/color_pallet_Component.dart';
import '../application/note_content_ctrl.dart';
import '../domain/note.dart';

class NoteContentScreen extends StatefulWidget {
  final Note? note;
  NoteContentScreen({Key? key, this.note});

  @override
  State<NoteContentScreen> createState() => _NoteContentScreenState();
}

class _NoteContentScreenState extends State<NoteContentScreen> {
  late NoteContentCTRL ctrl;

  @override
  void initState() {
    ctrl = Get.put(NoteContentCTRL(noteData: widget.note));
    super.initState();
  }

  @override
  void dispose() {
    ctrl.dispose();
    Get.delete<NoteContentCTRL>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: ctrl.scaffoldBackgroundColor,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title:             Text(
            'Edited: ${DateFormat.yMMMd().format(ctrl.editedDate)}', //TODO get last edited date from the note
            style: Get.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.undo),
                onPressed: () {
                  ctrl.richTextCtrl.undo();
                }),
            IconButton(
                icon: Icon(Icons.redo),
                onPressed: () {
                  ctrl.richTextCtrl.redo();
                }),
            IconButton(
                icon: Icon(Icons.cleaning_services_rounded),
                onPressed: () {
                  ctrl.richTextCtrl.clear();
                }),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.bottomLeft,
              child: QuillToolbar.simple(
                configurations: QuillSimpleToolbarConfigurations(
                  controller: ctrl.richTextCtrl,
                  sharedConfigurations: const QuillSharedConfigurations(
                    locale: Locale('en'),
                  ),
                  sectionDividerSpace: 1,
                  showRedo: false,
                  showUndo: false,
                  showFontFamily: false,
                  showDirection: true,
                  showFontSize: false,
                  showItalicButton: false,
                  showUnderLineButton: false,
                  showStrikeThrough: false,
                  showCodeBlock: false,
                  showBackgroundColorButton: false,
                  showClearFormat: false,
                  showSmallButton: false,
                  showIndent: false,
                  showLink: false,
                  showListNumbers: false,
                  showInlineCode: false,
                  showSuperscript: false,
                  showSubscript: false,
                  showHeaderStyle: false,
                  showSearchButton: false,
                  showListCheck: false,
                  showColorButton: false,
                  customButtons: [
                    QuillToolbarCustomButtonOptions(
                        icon: InkWell(
                            key: ctrl.colorPalletButtonKey,
                            child: PIMIcons.fromAsset(
                                iconName: PIMIcons.brush,
                                color: Get.theme.iconTheme.color!),
                            onTap: () async {
                              Color? sColor = await ColorPallet.showColorPallet(
                                context: context,
                                buttonKey: ctrl.colorPalletButtonKey,
                                colorPalletPosition: ColorPalletPosition.above
                              );
                              if (sColor != null) {
                                ctrl.setNoteColor(sColor);
                              }
                            })),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                child: Icon(
                  Icons.check,
                  size: 32,
                ),
                backgroundColor: Get.theme.colorScheme.tertiaryContainer,
                foregroundColor: Get.theme.colorScheme.onTertiaryContainer,
                onPressed: () {
                  ctrl.saveNote();
                },
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: TextField(
                controller: ctrl.titleController,
                style: Get.theme.textTheme.headlineMedium,
                decoration: InputDecoration(
                  icon: PIMIcons.fromAsset(
                      iconName: PIMIcons.edit, color: Get.iconColor!, size: 32),
                  alignLabelWithHint: false,
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  enabledBorder:
                      OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder:
                      OutlineInputBorder(borderSide: BorderSide.none),
                  hintText: 'Title.',
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(18),
                child: QuillEditor.basic(
                  configurations: QuillEditorConfigurations(
                    controller: ctrl.richTextCtrl,
                    readOnly: false,
                    textSelectionThemeData: TextSelectionThemeData(
                      cursorColor: Get.theme.colorScheme.surfaceVariant,
                      selectionColor: Get.theme.colorScheme.onSurface.withOpacity(0.2),
                      selectionHandleColor: Get.theme.colorScheme.onSurfaceVariant,
                    ),
                    sharedConfigurations: const QuillSharedConfigurations(
                      locale: Locale('en'),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
