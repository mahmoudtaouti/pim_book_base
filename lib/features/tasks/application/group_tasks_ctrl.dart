import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pim_book/features/tasks/application/tasks_ctrl.dart';
import 'package:pim_book/features/tasks/domain/tasks_repository.dart';

import '../data/tasks_db_worker.dart';
import '../domain/task.dart';
import 'new_task_ctrl.dart';

class NewGroupTaskController extends GetxController {
  TasksRepository tasksRepository = TasksDBWorker();

  final _titleController = TextEditingController();
  final _newTaskUnitController = TextEditingController();
  final _dueDate = initDueDate.obs;

  TextEditingController get titleController => _titleController;
  TextEditingController get newTaskUnitController => _newTaskUnitController;
  DateTime get dueDate => _dueDate.value;

  // Use RxList to handle dynamic task units
  final RxList<String> _taskUnits = <String>[].obs;
  List<String> get taskUnits => _taskUnits;

  void addTaskUnit(String taskUnit) {
    if (taskUnit.isNotEmpty) {
      _taskUnits.add(taskUnit.trim());
      _newTaskUnitController.clear();
    }
  }

  void removeTaskUnit(String taskUnit) {
    _taskUnits.remove(taskUnit);
  }

  void clearTaskUnits() {
    _taskUnits.clear();
  }

  Future<void> pickDueDate(Function onSelectDate) async {
    final pickedDate = await onSelectDate.call();
    if (pickedDate != null) {
      _dueDate.value = pickedDate;
    }
  }

  bool isDueDateSelected(){
    return this.dueDate != initDueDate;
  }

  void clearControllers() {
    _titleController.clear();
    _newTaskUnitController.clear();
    _taskUnits.clear();
  }

  void createGroupTask() async {
    Get.back();

    final title = _titleController.text;
    final dateNow = DateTime.now().millisecondsSinceEpoch;
    addTaskUnit(_newTaskUnitController.text);

    final groupTask = GroupTask(
      title: title,
      dueDate: dueDate.millisecondsSinceEpoch,
      checked: false,
      dateCreated: dateNow,
      dateEdited: dateNow,
    );

    // Use a for loop to add TaskUnit instances to the GroupTask
    for (final taskUnit in _taskUnits) {
      groupTask.addTask(TaskUnit(title: taskUnit));
    }

    groupTask.isValid().fold(
        (l) => Get.showSnackbar(GetSnackBar(
              title: 'Empty Group',
              message: "not saved",
              duration: Duration(seconds: 1),
            )), (r) async {
      Get.showSnackbar(GetSnackBar(
          title: 'New Group',
          message: "successfully saved",
          duration: Duration(seconds: 1)));
      await tasksRepository.createGroup(groupTask);
      final TasksController listCtrl = Get.find();
      listCtrl.fetchAll();
    });

    // Show success message
    clearControllers();
  }
}
