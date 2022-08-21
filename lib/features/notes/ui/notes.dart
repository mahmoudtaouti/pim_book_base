import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:pim_book/features/notes/application/notes_controller.dart';
import 'package:pim_book/features/notes/domain/note.dart';


class Notes extends StatelessWidget {

  final NotesController notesCtrl = Get.put(NotesController());

  @override
  Widget build(BuildContext context) {
        return Obx(() {
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                heroTag: "homeFloatingActionButton",
                onPressed: () {
                  //go to noteEntry Screen
                  notesCtrl.onNewNotePressed();
                },
                child: Icon(Icons.add),
              ),
              body:  ListView.builder(
                      padding: EdgeInsets.only(bottom: 80.0),
                      itemCount: notesCtrl.notesList.length,
                      itemBuilder: (BuildContext context,int index){
                        Note note = notesCtrl.notesList[index];
                        late Color color;
                        late Color barColor;
                        switch(note.color){
                          case 'red' :
                            color = Colors.redAccent.shade100;
                            barColor =  Colors.red;
                            break;
                          case 'green' :
                            color = Colors.greenAccent.shade100;
                            barColor =  Colors.green;
                            break;
                          case 'blue' :
                            color = Colors.lightBlueAccent.shade100;
                            barColor =  Colors.blue;
                            break;
                          case 'yellow' :
                            color = Colors.yellowAccent.shade100;
                            barColor =  Colors.amber;
                            break;
                          case 'grey' :
                            color = Colors.grey.shade100;
                            barColor =  Colors.blueGrey;
                            break;
                          case 'purple' :
                            color = Colors.indigoAccent.shade100;
                            barColor =  Colors.indigo;
                            break;
                          default :
                            color = Colors.grey.shade300;
                            barColor =  Colors.grey.shade600;
                        }


                        return Container(
                          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                          child: Slidable(
                            actionPane: SlidableStrechActionPane(),
                            actionExtentRatio: 0.2,
                            secondaryActions : [
                              IconSlideAction(
                                caption: "delete",
                                foregroundColor: Colors.redAccent,
                                color: Colors.white.withOpacity(0.0),
                                icon: Icons.delete,
                                //iconWidget: Icon(Icons.delete,color: Colors.redAccent,),
                                onTap: ()=> _deleteNote(context,note),
                              )
                            ],
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: color,
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(8.0),bottomRight: Radius.circular(8.0))
                                  ),
                                  child: ListTile(
                                    title: Text("${note.title}",style: TextStyle(fontSize: 18,color: Colors.black87),),
                                    subtitle:  Text("${note.content}",style: TextStyle(fontSize: 18,color :Colors.black.withOpacity(0.5)),),
                                    onTap: () async{
                                      //go edit this note in NotesEntry
                                      notesCtrl.onSelectNote(note);
                                    },
                                  ),
                                ),
                                Positioned(
                                  left: 0.0,
                                  top: 0.0,
                                  bottom: 0.0,
                                  child: Container(
                                    width: 6,
                                    color: barColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }
                  )
            );
          }
        );

  }

  Future _deleteNote(BuildContext context , Note inNote){
    return showDialog(context: context, builder: (BuildContext inContext){

      return AlertDialog(
        title: Text("Delete"),
        content: Text("Are you sure you wont delete ${inNote.title}"),
        actions: [
          TextButton(
              onPressed: (){
                Navigator.pop(inContext);
              },
              child: Text("cancel")
          ),
          TextButton(
              onPressed: () async {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        duration: Duration(seconds: 1),
                        content: Text("Note deleted",style: TextStyle(color: Colors.redAccent),)
                    )
                );
                await notesCtrl.onDeleteNote(inNote.id!);
                Navigator.pop(inContext);
              },
              child: Text("delete")
          ),
        ],
      );
    });
  }

}