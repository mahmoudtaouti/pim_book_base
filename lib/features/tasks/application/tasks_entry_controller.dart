import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pim_book/core/utils.dart';
import 'package:pim_book/features/tasks/data/tasks_db_worker.dart';
import 'package:pim_book/features/tasks/domain/task.dart';

class TasksEntryController extends GetxController{

  Task task;
  var chosenDate = Utils.getNowDateStringFormat().obs;

  late final TextEditingController descriptionTextEditingController ;
  final GlobalKey<FormState> formKey = GlobalKey();

  TasksEntryController(this.task){
    descriptionTextEditingController = TextEditingController();
    descriptionTextEditingController.addListener(() {
      task.description = descriptionTextEditingController.text;
    });
    descriptionTextEditingController.text = task.description;
  }

  onSavePressed()async{
    if (!formKey.currentState!.validate()) return;
    TasksDBWorker db = TasksDBWorker();
    if (task.id == null)  {
     await db.create(task);
    } else{
     await db.update(task);
    }
    Get.back();
  }

}