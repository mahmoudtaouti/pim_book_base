import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pim_book/features/tasks/application/tasks_entry_controller.dart';
import '../../../core/utils.dart';
import '../domain/task.dart';

class TasksEntry extends StatelessWidget {

  late final TasksEntryController entryCtrl ;

  TasksEntry(Task task){
    entryCtrl = Get.put(TasksEntryController(task));
  }

  _save(BuildContext context)async{
    entryCtrl.onSavePressed();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            duration: Duration(seconds: 2),
            content:Text("Task saved",style: TextStyle(
                color: Colors.greenAccent),
            )
        )
    );
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      bottomNavigationBar:Padding(
        padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
        child: Row(
          children: [
            TextButton(onPressed: (){
              FocusScope.of(context).requestFocus(FocusNode());
              Navigator.pop(context);
            }, child: Text("cancel",style: TextStyle(fontSize: 18,color: Theme.of(context).buttonColor),)),
            Spacer(),
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
                controller: entryCtrl.descriptionTextEditingController,
                decoration: InputDecoration(
                  hintText: "description",
                  prefixIcon: Icon(Icons.task),
                ),
                validator: (String? inValue){
                  if (inValue!.length == 0) {
                    return "please enter description";
                  }
                  return null;
                },

            ),
            ListTile(
              title: Text("Due Date"),
              subtitle: _DueDateTile(entryCtrl: entryCtrl,),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: ()async{
                  FocusScope.of(context).requestFocus(FocusNode());
                  String chosenDate = await Utils.selectDate(context, entryCtrl.chosenDate.value);
                  entryCtrl.task.dueDate = chosenDate;
                  chosenDate = DateFormat.yMMMMd("en_US").format(Utils.dateTimeFromString(chosenDate));
                },
              ),
            )
          ],
        ),

      ),
    );
  }
}


class _DueDateTile extends StatelessWidget {
  _DueDateTile({Key? key,required this.entryCtrl}) : super(key: key);

  final TasksEntryController entryCtrl;
  @override
  Widget build(BuildContext context) {

    return  Obx(() {
        return Text(
            entryCtrl.chosenDate.value
        );
      }
    );
  }

}

