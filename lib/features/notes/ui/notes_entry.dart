import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pim_book/features/notes/application/notes_controller.dart';
import 'package:pim_book/features/notes/application/notes_entry_controller.dart';
import 'package:pim_book/features/notes/domain/note.dart';


class NotesEntry extends StatelessWidget {


  late final NotesEntryController entryCtrl;

  NotesEntry(Note inNote){
    entryCtrl = Get.put(NotesEntryController(note : inNote));
  }

  /// save note to database and show snack bar
  /// and back to the list screen
  _save(BuildContext context)async{
    if (!entryCtrl.formKey.currentState!.validate()) return;
    entryCtrl.onSaveNote();
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            duration: Duration(seconds: 2),
            content:Text("Note saved",style: TextStyle(
                color: Colors.greenAccent),
            )
        )
    );
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(onPressed: (){
              FocusScope.of(context).requestFocus(FocusNode());
              Navigator.pop(context);
            }, child: Text("cancel",style: TextStyle(fontSize: 18),)),
            TextButton(onPressed: (){
              _save(context);
            }, child: Text("save",style: TextStyle(color: Colors.greenAccent,fontSize: 18),)),
          ],
        ),
      ),
      body: Form(
        key: entryCtrl.formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: entryCtrl.titleTextEditingController,
              decoration: InputDecoration(
                hintText: "title",
                prefixIcon: Icon(Icons.title),
              ),
              validator: (String? inValue){
                if (inValue!.length == 0) {
                  return "please enter a title";
                }
                return null;
              },
            ),
            TextFormField(
              controller: entryCtrl.contentTextEditingController,
              keyboardType: TextInputType.multiline,
              maxLines: 20,
              decoration: InputDecoration(
                hintText: "content",
                prefixIcon: Icon(Icons.content_paste),
              ),
              validator: (String? inValue){
                return null;
              },
            ),
           ColorTentList(entryCtrl: entryCtrl,),
          ],
        ),
      ),
    );
  }
}


class ColorTentList extends StatelessWidget {
  const ColorTentList({Key? key,required this.entryCtrl}) : super(key: key);
  final NotesEntryController entryCtrl;
  @override
  Widget build(BuildContext context) {
    return  ListTile(
      leading: Icon(Icons.color_lens,),
      title: Row(children: [
        _ColorTent(color: Colors.redAccent, colorTxt: "red",entryCtrl: entryCtrl,),
        Spacer(),
        _ColorTent(color: Colors.greenAccent, colorTxt: "green",entryCtrl: entryCtrl,),
        Spacer(),
        _ColorTent(color: Colors.blueAccent, colorTxt: "blue",entryCtrl: entryCtrl,),
        Spacer(),
        _ColorTent(color: Colors.yellowAccent, colorTxt: "yellow",entryCtrl: entryCtrl,),
        Spacer(),
        _ColorTent(color: Colors.grey, colorTxt: "grey",entryCtrl: entryCtrl,),
        Spacer(),
        _ColorTent(color: Colors.indigo, colorTxt: "purple",entryCtrl: entryCtrl,),
      ],

      ),
    );
  }
}



class _ColorTent extends StatelessWidget {
  const _ColorTent({Key? key, required this.color, required this.colorTxt,required this.entryCtrl})
      : super(key: key);

  final NotesEntryController entryCtrl;
  final Color color;
  final String colorTxt;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        entryCtrl.onSelectColor(colorTxt);
      },
      child: Obx(() {
          return Container(
            height: 41,width: 41,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: entryCtrl.color.value == colorTxt ? color : color.withOpacity(0.3),
            ),
          );
        }
      ),
    );
  }
}

