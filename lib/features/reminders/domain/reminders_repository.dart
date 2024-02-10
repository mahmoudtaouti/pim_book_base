import 'reminder.dart';

abstract class RemindersRepository{

  Future<int> create(Reminder reminder);
  Future<Reminder> get(int id);
  Future<int> update(Reminder note);
  Future<int> delete(int id);

  Future<List<Reminder>> getAll();
}