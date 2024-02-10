import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pim_book/features/tasks/data/tasks_db_worker.dart';
import '../../../core/utils.dart';
import '../domain/task.dart';
import '../domain/tasks_repository.dart';

class TasksController extends GetxController {
  final TasksRepository tasksRepository = TasksDBWorker();

  TasksController();

  var tasks = <dynamic>[].obs;
  var _currentSegment = 0.obs;

  int get currentSegment => _currentSegment.value;

  changeSegment(int value){
    _currentSegment.value = value;
    // switch(_currentSegment.value){
    //   case 0: {fetchAll();break;};
    //   case 1: {fetchTasks();break;};
    //   case 2: {fetchGroups();break;};
    // }
  }

  @override
  void onInit() {
    super.onInit();
    fetchAll();
  }

  Future<void> fetchAll() async {
    try {
      final fetchedTasks = await tasksRepository.getAll();
      tasks.value = fetchedTasks;
    } catch (e) {
      print('Error fetching tasks: $e');
    }
  }

  Future<void> fetchTasks() async {
    try {
      final fetchedTasks = await tasksRepository.getOnlyTasks();
      tasks.value = fetchedTasks;
    } catch (e) {
      print('Error fetching tasks: $e');
    }
  }

  Future<void> fetchGroups() async {
    try {
      final fetchedTasks = await tasksRepository.getOnlyGroups();
      tasks.value = fetchedTasks;
    } catch (e) {
      print('Error fetching tasks: $e');
    }
  }

  ///TODO rather then delete the Task, add it to Archive. Thus user can access it if he want
  void deleteThisTask(Task task) async {
    tasks.remove(task);
    await tasksRepository.deleteTask(task.id!);
    update();
    Get.showSnackbar(GetSnackBar(title: 'Task Deleted',message: 'Task: ${task.title}',duration: Duration(seconds: 1),));
  }

  void deleteThisGroup(GroupTask groupTask) {
    tasks.remove(groupTask);
    tasksRepository.deleteGroup(groupTask.id!);
    Get.showSnackbar(GetSnackBar(title: 'Group Deleted',message: 'Group: ${groupTask.title}',duration: Duration(seconds: 1),));
    update();
  }


  void updateTaskCheckedStatus(Task task, bool newValue) {
    task.checked = !task.checked;
    task.dateEdited = DateTime.now().millisecondsSinceEpoch;
    tasksRepository.updateTask(task);
    update();
  }

  void updateGroupTaskCheckedStatus(GroupTask groupTask) {
    groupTask.checked = groupTask.taskUnits.every((taskUnit) => taskUnit.checked);
    groupTask.dateEdited = DateTime.now().millisecondsSinceEpoch;
    tasksRepository.updateGroup(groupTask);
    update();
  }

  String displayDateIfValid(dynamic task){
    return Utils.isDateValid(DateTime.fromMillisecondsSinceEpoch(task.dueDate))
        ? DateFormat.MMMMd().format(
        DateTime.fromMillisecondsSinceEpoch(
            task.dueDate))
        :'';
  }

  @override
  void onClose() {
    super.onClose();
  }


}