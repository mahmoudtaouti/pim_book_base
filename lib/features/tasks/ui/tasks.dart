
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pim_book/features/tasks/application/tasks_controller.dart';
import '../../../core/utils.dart';
import '../domain/task.dart';


class Tasks extends StatelessWidget {

  final TasksController tasksCtrl = Get.put(TasksController());

  Future _deleteTask(BuildContext context,Task task){
    return showDialog(context: context, builder: (BuildContext inContext){

      return AlertDialog(
        title: Text("Delete"),
        content: Text("Are you sure you wont delete ${task.description}"),
        actions: [
          TextButton(
              onPressed: (){
                Navigator.pop(inContext);
              },
              child: Text("cancel")
          ),
          TextButton(
              onPressed: () async{
                tasksCtrl.onDeleteTask(task.id!);
                Navigator.pop(inContext);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        duration: Duration(seconds: 1),
                        content: Text("Task deleted",style: TextStyle(color: Colors.redAccent),)
                    )
                );
              },
              child: Text("delete")
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            tasksCtrl.onNewTaskPressed();
          },
          child: Icon(Icons.add),
        ),
        body: Obx((){

            return ListView.builder(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
              itemCount: tasksCtrl.taskList.length,
              itemBuilder: (buildContext,index){
                Task task = tasksCtrl.taskList[index];
                String dueDate = "";
                if (task.dueDate != null) {
                  DateTime date = Utils.dateTimeFromString(task.dueDate!);
                  dueDate = DateFormat.yMMMMd("en_US").format(date.toLocal());
                }
                return Slidable(
                  actionPane: SlidableStrechActionPane(),
                  actionExtentRatio: 0.2,
                  actions: [
                    IconSlideAction(
                      caption: "edit",
                      foregroundColor: Colors.lightBlueAccent,
                      icon: Icons.edit,
                      onTap: (){
                       tasksCtrl.onEditTask(task);
                      },
                    )
                  ],
                  secondaryActions: [
                    IconSlideAction(
                      caption: "delete",
                      foregroundColor: Colors.redAccent,
                      color: Colors.white.withOpacity(0.0),
                      icon: Icons.delete,
                      onTap: ()=> _deleteTask(context,task),
                    )
                  ],
                  child: Stack(
                    //TODO listTile not updated when task mark as completed
                    children: [
                      ListTile(
                        enabled: task.completed =="true" ? false : true,
                        leading: _CheckBox(tasksCtrl: tasksCtrl,task: task,),
                        title: Text("${task.description}",style: task.completed =="true" ?
                        TextStyle(
                            decoration: TextDecoration.lineThrough
                        ) :
                        TextStyle(
                            decoration: TextDecoration.none
                        ),
                        ),
                        subtitle: Text("$dueDate"),
                      ),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Divider(height: 0,thickness: 1,indent: 20,endIndent: 20,color: task.completed =="true" ? Colors.white.withOpacity(0.0):Colors.amber,),)
                    ],
                  ),
                );
              },
            );
          }
        ));
  }
}


class _CheckBox extends StatefulWidget {
  const _CheckBox({Key? key,required this.tasksCtrl,required this.task}) : super(key: key);

  final TasksController tasksCtrl;
  final Task task;



  @override
  _CheckBoxState createState() => _CheckBoxState();
}

class _CheckBoxState extends State<_CheckBox> {

  late bool isChecked;

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      onChanged: (bool? value) async{
        isChecked = value!;
        widget.tasksCtrl.onToggleTask(widget.task,isChecked);
        setState(() {});
      },
      value: widget.task.completed == "true" ? true : false,);
  }
}

