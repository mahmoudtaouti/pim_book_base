
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:pim_book/features/tasks/data/tasks_db_worker.dart';
import 'package:pim_book/features/tasks/domain/task.dart';
import 'package:pim_book/features/tasks/domain/tasks_model.dart';
import 'package:pim_book/core/utils.dart' as utils;
import 'package:provider/provider.dart';

class TasksList extends StatefulWidget {
  @override
  _TasksListState createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
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
                await TasksDBWorker.instance.delete(task.id!);
                Navigator.pop(inContext);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        duration: Duration(seconds: 2),
                        content: Text("Task deleted",style: TextStyle(color: Colors.redAccent),)
                    )
                );
               context.read<TasksModel>().loadData("tasks", TasksDBWorker.instance);
              },
              child: Text("delete")
          ),
        ],
      );
    });
  }



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TasksModel readableTasksModel = Provider.of<TasksModel>(context,listen: false);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          readableTasksModel.entityBeingEdited = Task();
          readableTasksModel.stackIndex = 1;
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
          itemCount: context.watch<TasksModel>().data.length,
          itemBuilder: (buildContext,index){
            Task task = context.watch<TasksModel>().data[index];
            String dueDate = "";
            if (task.dueDate != null) {
              DateTime date = utils.dateTimeFromString(task.dueDate!);
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
                    readableTasksModel.entityBeingEdited = task;
                    if (readableTasksModel.entityBeingEdited.dueDate == null)   {
                      readableTasksModel.chosenDate = null;
                    }  else{
                      readableTasksModel.chosenDate = readableTasksModel.entityBeingEdited.dueDate;
                    }
                    readableTasksModel.stackIndex = 1;
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
                children: [
                  ListTile(
                    enabled: task.completed =="true" ? false : true,
                    leading: Checkbox(
                      onChanged: (bool? value) async{
                        task.completed = value.toString();
                        await TasksDBWorker.instance.update(task);
                        readableTasksModel.notifyListeners();
                      },
                      value: task.completed == "true" ? true : false,),
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
    ));
  }
}
