import 'package:pim_book/features/tasks/domain/task.dart';

abstract class TasksRepository{

  Future<int> createTask(Task task);
  Future<Task> getTask(int id);
  Future<int> updateTask(Task task);
  Future<int> deleteTask(int id);

  Future<int> createGroup(GroupTask groupTask);
  Future<GroupTask> getGroup(int id);
  Future<int> updateGroup(GroupTask groupTask);
  Future<int> deleteGroup(int id);

  Future<List<dynamic>> getAll(); //get the groups of tasks
  Future<List<Task>> getOnlyTasks(); // only tasks
  Future<List<GroupTask>> getOnlyGroups(); // only groups

  Future<List<dynamic>> getAllDueDate(); // By due date (the task deadline)
  Future<List<dynamic>> getAllChecked(); // only the checked tasks
  Future<List<dynamic>> getAllUnchecked(); // only the unchecked tasks

}

