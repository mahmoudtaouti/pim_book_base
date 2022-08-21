import 'package:pim_book/features/tasks/domain/task.dart';

abstract class ITasksFacade{
  Future<Task> getTask(int id);
  Future<List> getAll();//no Data failure
  Future create(Task inNote);
  Future update(Task inNote);
  Future delete(int inId);
// Future createBackup(); TODO save locale backup
// Future syncDataFromServer();
}