// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:pim_book/features/notes/data/notes_db_worker.dart';
// import 'package:pim_book/features/notes/domain/note.dart';
// import 'package:pim_book/features/notes/domain/notes_model.dart';
// import 'package:scoped_model/scoped_model.dart';
// import 'package:pim_book/core/utils.dart' as utils;
//
// class NotesList extends StatelessWidget {
//
//   Future _deleteNote(BuildContext context , Note inNote){
//     return showDialog(context: context, builder: (BuildContext inContext){
//       return AlertDialog(
//         title: Text("Delete"),
//         content: Text("Are you sure you wont delete ${inNote.title}"),
//         actions: [
//           TextButton(
//               onPressed: (){
//                 Navigator.pop(inContext);
//               },
//               child: Text("cancel")
//           ),
//           TextButton(
//               onPressed: () async {
//                 await NotesDBWorker.instance.delete(inNote.id!);
//                 Navigator.pop(inContext);
//                 ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       duration: Duration(seconds: 2),
//                         content: Text("Note deleted",style: TextStyle(color: Colors.redAccent),)
//                     )
//                 );
//                 notesModel.loadData("notes", NotesDBWorker.instance);
//               },
//               child: Text("delete")
//           ),
//         ],
//       );
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     return ScopedModel<NotesModel>(
//         model: notesModel,
//         child: ScopedModelDescendant<NotesModel>(
//           builder: (BuildContext context ,Widget? child,NotesModel model)=>
//               Scaffold(
//                 floatingActionButton: FloatingActionButton(
//                   onPressed: () {
//                     notesModel.entityBeingEdited = Note();
//                     notesModel.color = null;
//                     notesModel.stackIndex = 1;
//                   },
//                   child: Icon(Icons.add),
//                 ),
//                 body: ListView.builder(
//                     itemCount: notesModel.data.length,
//                     itemBuilder: (BuildContext context,int index){
//
//                       Note note = notesModel.data[(index)];
//                       late Color color;
//                       late Color barColor;
//                       switch(note.color){
//                         case 'red' :
//                           color = Colors.redAccent;
//                           barColor =  Colors.red;
//                           break;
//                         case 'green' :
//                           color = Colors.greenAccent;
//                           barColor =  Colors.green;
//                           break;
//                         case 'blue' :
//                           color = Colors.blueAccent;
//                           barColor =  Colors.blue;
//                           break;
//                         case 'yellow' :
//                           color = Colors.yellowAccent;
//                           barColor =  Colors.yellow;
//                           break;
//                         case 'grey' :
//                           color = Colors.grey;
//                           barColor =  Colors.blueGrey;
//                           break;
//                         case 'purple' :
//                           color = Colors.indigoAccent;
//                           barColor =  Colors.indigo;
//                           break;
//                         default :
//                           color = Colors.grey;
//                           barColor =  Colors.blueGrey;
//                       }
//
//
//                       return Container(
//                         padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
//                         child: Slidable(
//                           actionPane: SlidableStrechActionPane(),
//                           actionExtentRatio: 0.2,
//                           secondaryActions: [
//                             IconSlideAction(
//                               caption: "delete",
//                               foregroundColor: Colors.redAccent,
//                               color: Colors.white.withOpacity(0.0),
//                               icon: Icons.delete,
//                               //iconWidget: Icon(Icons.delete,color: Colors.redAccent,),
//                               onTap: ()=> _deleteNote(context,note),
//                             )
//                           ],
//                           child: Stack(
//                             children: [
//                               Container(
//                                 decoration: BoxDecoration(
//                                   color: color,
//                                   borderRadius: BorderRadius.only(topRight: Radius.circular(8.0),bottomRight: Radius.circular(8.0))
//                                 ),
//                                 child: ListTile(
//                                   title: Text("${note.title}",style: TextStyle(fontSize: 18,color: Colors.black87),),
//                                   subtitle:  Text("${note.content}",style: TextStyle(fontSize: 18,color :Colors.black.withOpacity(0.5)),),
//                                   onTap: ()async{
//                                     notesModel.entityBeingEdited = await NotesDBWorker.instance.get(note.id!);
//                                     notesModel.color = note.color;
//                                     notesModel.stackIndex = 1;
//                                   },
//                                 ),
//                               ),
//                               Positioned(
//                                 left: 0.0,
//                                 top: 0.0,
//                                 bottom: 0.0,
//                                 child: Container(
//                                   width: 6,
//                                   color: barColor,
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       );
//                     }
//                 ),
//               )
//         )
//     );
//   }
// }
//
//
// // await notesModel.loadData("notes",NotesBDWorker.instance);
