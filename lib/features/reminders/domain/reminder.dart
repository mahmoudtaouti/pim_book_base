import 'package:dartz/dartz.dart';

import '../../../core/domain/failures.dart';

class Reminder implements Comparable<Reminder> {
  int? id;
  String title = '';
  String description = '';
  int date;
  int time;
  String color;
  int duration;
  int dateCreated;
  int dateEdited;

  Reminder({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.color,
    required this.duration,
    required this.dateCreated,
    required this.dateEdited,
  });

  Reminder updateData({
  String? title,
  String? description,
  int? date,
  int? time,
  String? color,
  int? duration,
  int? dateEdited,}){
    this.title = title ?? this.title;
    this.description = description ?? this.description;
    this.date = date ?? this.date;
    this.time = time ?? this.time;
    this.color = color ?? this.color;
    this.duration = duration ?? this.duration;
    this.dateEdited = dateEdited ?? this.dateEdited;
    return this;
  }

  Reminder._set(
    this.id,
    this.title,
    this.description,
    this.date,
    this.time,
    this.color,
    this.duration,
    this.dateCreated,
    this.dateEdited,
  );

  factory Reminder.fromMap(Map<String, dynamic> map) {
    return Reminder._set(
      map["id"],
      map["title"],
      map["description"],
      map["date"],
      map['time'],
      map['color'],
      map['duration'],
      map['dateCreated'],
      map['dateEdited'],
    );
  }

  static Map<String, dynamic> toMap(Reminder reminder) {
    return {
      "id": reminder.id,
      "title": reminder.title,
      "description": reminder.description,
      "date": reminder.date,
      "time": reminder.time,
      "color": reminder.color,
      "duration": reminder.duration,
      "dateCreated": reminder.dateCreated,
      "dateEdited": reminder.dateEdited,
    };
  }

  Either<ValueFailure, Unit> isValid() {
    //TODO redo the validation
    if (title.isNotEmpty || description.isNotEmpty) {
      return right(unit);
    } else {
      return left(ValueFailure.notValidToSaveInDatabase());
    }
  }

  @override
  int compareTo(Reminder other) {
    if (dateEdited < other.dateEdited) {
      return -1;
    } else if (dateEdited > other.dateEdited) {
      return 1;
    } else {
      return 0;
    }
  }
}
