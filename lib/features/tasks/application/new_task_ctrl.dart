import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pim_book/features/tasks/application/tasks_ctrl.dart';
import 'package:pim_book/features/tasks/data/tasks_db_worker.dart';
import '../domain/task.dart';


final initDueDate = DateTime(0);

class NewTaskController extends GetxController {
  final _titleController = TextEditingController();
  final focusNode = FocusNode();
  var _dueDate = initDueDate.obs;

  TextEditingController get titleController => _titleController;
  DateTime get dueDate => _dueDate.value;

  void clearControllers() {
    _titleController.clear();
  }

  bool isDueDateSelected(){
    return this.dueDate != initDueDate;
  }

  void createTask(TasksDBWorker tasksRepository) async {

    Get.back();
    final dateNow = DateTime.now().millisecondsSinceEpoch;

    final task = Task(
      title:  _titleController.text,
      dueDate: dueDate.millisecondsSinceEpoch,
      checked: false,
      dateCreated:dateNow,
      dateEdited: dateNow,
    );

    task.isValid().fold(
            (l) {
              Get.showSnackbar(GetSnackBar(title: 'Empty Task',message: "not saved",duration: Duration(seconds: 1),));
            },
            (r) async {
              await tasksRepository.createTask(task);
              // Show success message
              Get.showSnackbar(GetSnackBar(title: 'New Task',message: "successfully saved",duration: Duration(seconds: 1)));
              final TasksController listCtrl = Get.find();
              listCtrl.fetchAll();
            }
    );
    clearControllers();
  }

  Future<void> selectDate(Function openDatePicker) async {
    DateTime? picked = await openDatePicker.call();
    if (picked != null) {
      this._dueDate.value = picked;
      print(dueDate.toLocal());

    }
  }

}