import 'package:flutter/material.dart';
import 'package:pim_book/features/tasks/data/tasks_db_worker.dart';
import 'package:pim_book/features/tasks/domain/tasks_model.dart';
import 'package:provider/provider.dart';
import 'package:pim_book/core/utils.dart' as utils;

class TasksEntry extends StatefulWidget {

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  _TasksEntryState createState() => _TasksEntryState();
}

class _TasksEntryState extends State<TasksEntry> {
  late final TextEditingController _descriptionTextEditingController ;



  _save(BuildContext context , TasksModel model)async{
    if (!widget._formKey.currentState!.validate()) return;
    widget._formKey.currentState!.save();
    if (model.entityBeingEdited.id == null)  {
      await TasksDBWorker.instance.create(model.entityBeingEdited);
    } else{
      await TasksDBWorker.instance.update(model.entityBeingEdited);
    }
    model.loadData("tasks", TasksDBWorker.instance);
    model.stackIndex = 0;
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
  void initState() {
    _descriptionTextEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _descriptionTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TasksModel model = Provider.of<TasksModel>(context,listen: false);
    _descriptionTextEditingController.text = model.entityBeingEdited.description;
    return  Scaffold(
      bottomNavigationBar:Padding(
        padding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(onPressed: (){
              model.stackIndex = 0;
            }, child: Text("cancel",style: TextStyle(fontSize: 18),)),
            TextButton(onPressed: (){
              _save(context,model);
            }, child: Text("save",style: TextStyle(color: Colors.greenAccent,fontSize: 18),)),
          ],
        ),
      ),
      body: Form(
        key: widget._formKey,
        child: ListView(
          children: [
            TextFormField(
                controller: _descriptionTextEditingController,
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
                onSaved: (String? value){
                  model.entityBeingEdited.description = value;
                },
            ),
            ListTile(
              title: Text("Due Date"),
              subtitle: Text(
                  model.chosenDate == null ?
                  "select a date" : model.chosenDate!),

              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: ()async{
                  String chosenDate = await utils.selectDate(context, model, model.entityBeingEdited.dueDate);
                  model.entityBeingEdited.dueDate = chosenDate;
                },
              ),
            )
          ],
        ),

      ),
    );
  }
}
