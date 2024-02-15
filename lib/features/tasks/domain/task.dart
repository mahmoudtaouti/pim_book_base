
import 'dart:convert';
import 'package:dartz/dartz.dart';
import '../../../core/domain/failures.dart';

class TaskUnit{
  String title = '';
  bool checked = false;

  TaskUnit({required this.title, this.checked = false});

  Either<ValueFailure, TaskUnit> isValid() {
    if (this.title.isNotEmpty) {
      return right(this);
    } else {
      return left(ValueFailure.notValidToSaveInDatabase());
    }
  }

  factory TaskUnit.fromMap(Map<String, dynamic> inMap) {
    return TaskUnit(
      title: inMap["title"],
      checked: inMap["checked"] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "checked": checked ? 1 : 0,
    };
  }
}

class Task extends TaskUnit implements Comparable<Task> {
  int? id;
  int dueDate;
  int dateCreated;
  int dateEdited;


  Task({this.id, required String title, required this.dueDate, bool checked = false, required this.dateCreated, required this.dateEdited})
      : super(title: title, checked: checked);

  factory Task.fromMap(Map<String, dynamic> inMap) {
    return Task(
      id: inMap["id"],
      title: inMap["title"],
      dueDate: inMap["dueDate"],
      checked: inMap["checked"] == 1,
      dateCreated: inMap["dateCreated"],
      dateEdited: inMap["dateEdited"],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> baseMap = super.toMap();
    baseMap.addAll({
      "id": id,
      "dueDate": dueDate,
      "dateCreated": dateCreated,
      "dateEdited": dateEdited,
    });
    return baseMap;
  }

  @override
  int compareTo(Task other) {
    if (dateEdited < other.dateEdited) {
      return -1;
    } else if (dateEdited > other.dateEdited) {
      return 1;
    } else {
      return 0;
    }
  }
}



class GroupTask implements Comparable<GroupTask> {
  int? id;
  String title = '';
  List<TaskUnit> _taskUnits = [];
  int dueDate;
  bool checked = false;
  int dateCreated;
  int dateEdited;

  GroupTask({this.id,required this.title, required this.dueDate, required this.checked,required this.dateCreated, required this.dateEdited});

  GroupTask._set(
      this.id, this.title, this._taskUnits, this.dueDate, this.checked, this.dateCreated, this.dateEdited);

  Either<ValueFailure, Unit> addTask(TaskUnit taskUnit) {
    final validation = taskUnit.isValid();
    if (validation.isRight()) {
      _taskUnits.add(taskUnit);
      return right(unit);
    } else {
      return left(ValueFailure.emptyValue());
    }
  }

  void removeTask(int index) {
    _taskUnits.removeAt(index);
  }

  List<TaskUnit> get taskUnits => List.unmodifiable(_taskUnits);

  Either<ValueFailure, GroupTask> isValid() {
    if (_taskUnits.isNotEmpty) {
      return right(this);
    } else {
      return left(ValueFailure.notValidToSaveInDatabase());
    }
  }

  factory GroupTask.fromMap(Map<String, dynamic> inMap) {
    return GroupTask._set(
      inMap["id"],
      inMap["title"],
      (jsonDecode(inMap["tasks"] ?? '[]') as List<dynamic>)
          .map((e) => TaskUnit(
        title: e["title"],
        checked: e["checked"] == 1,
      ))
          .toList(),
      inMap["dueDate"],
      inMap["checked"] == 1,
      inMap["dateCreated"],
      inMap["dateEdited"],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id": this.id,
      "title": this.title,
      "tasks": jsonEncode(this._taskUnits.map((e) => e.toMap()).toList()),
      "dueDate": this.dueDate,
      "checked": this.checked ? 1 : 0,
      "dateCreated": this.dateCreated,
      "dateEdited": this.dateEdited,
    };
    return map;
  }

  @override
  int compareTo(GroupTask other) {
    if (dateEdited < other.dateEdited) {
      return -1;
    } else if (dateEdited > other.dateEdited) {
      return 1;
    } else {
      return 0;
    }
  }

}
