import 'package:pim_book/core/base_model.dart';
import 'package:pim_book/features/tasks/data/tasks_db_worker.dart';
import 'package:pim_book/features/tasks/domain/task.dart';

//TasksModel tasksModel = TasksModel();

class TasksModel extends BaseModel{

  TasksModel(){
    entityBeingEdited = Task();
    loadData("tasks", TasksDBWorker());
  }

 @override
  void notifyListeners() {
    // TODO: implement notifyListeners
    super.notifyListeners();
  }
}