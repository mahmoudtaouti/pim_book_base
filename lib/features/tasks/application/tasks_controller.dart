import 'package:get/get.dart';
import 'package:pim_book/features/tasks/data/tasks_db_worker.dart';
import 'package:pim_book/features/tasks/domain/task.dart';
import 'package:pim_book/features/tasks/ui/tasks_entry.dart';

class TasksController extends GetxController{

  var taskList = [].obs;
  Task taskBeingEdited = Task();
  var chosenDate;

  TasksController(){
    _updateListData();
  }


  _updateListData() async{
    taskList.value = await TasksDBWorker().getAll();
  }

  onNewTaskPressed() async{
    Get.to(()=> TasksEntry(taskBeingEdited))!.whenComplete(() => _updateListData());
  }

  onDeleteTask(int taskId)async{
    TasksDBWorker().delete(taskId).whenComplete(() =>   _updateListData());
  }

  onToggleTask(Task task,bool isChecked) async {

    task.completed = isChecked.toString();
    await TasksDBWorker().update(task);
    this.notifyChildrens();
  }

  onEditTask(Task task){
    taskBeingEdited = task;
    if (taskBeingEdited.dueDate == null)   {
      chosenDate = null;
    }  else{
      chosenDate = taskBeingEdited.dueDate;
    }
    Get.to(()=> TasksEntry(taskBeingEdited))!.whenComplete(() => _updateListData());
  }
}